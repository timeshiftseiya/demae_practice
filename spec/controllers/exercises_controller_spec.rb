require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :transaction
DatabaseCleaner.start

RSpec.describe ExercisesController, type: :controller do
  describe "exercise1" do
    before { get :exercise1 }
    it "user_idが1のuserの注文(order)件数を返すこと" do
      User.first.update(id: 1)
      expect(
        assigns(:result) == Order.all.select{|order| order.user_id == 1 }.size
      ).to eq true
    end
    it "ActiveRecord::Base#findを使っていること" do
      actual_methods(assigns(:query)).any?{|x| x.include?("find")}
    end
    it "ActiveRecord::Base#countを使っていること" do
      actual_methods(assigns(:query)).any?{|x| x.include?("count")}
    end
    it "User#ordersを使っていること" do
      actual_methods(assigns(:query)).any?{|x| x.include?("orders")}
    end

  end

  describe "exercise2" do
    before { get :exercise2 }
    it "最後の注文(order)をしたuserの名前を返すこと" do
      expect(
        assigns(:result) ==
          User.find(Order.all.sort{|a, b| b.created_at <=> a.created_at }[0].user_id).name
      ).to eq true
    end
  end

  describe "exercise3" do
    before { get :exercise3 }
    it "全てのcityのidとnameを返すこと" do
      expect(
        assigns(:result).ids == City.all.ids
      ).to eq true
    end
    it "ActiveRecord::Baseのメソッドを使って取得していること" do
      expect(
        assigns(:result).class.to_s == "City::ActiveRecord_Relation"
      ).to eq true
    end
    it "@resultが内包する全てのオブジェクトのクラスはCityであり、それらのオブジェクトはidとnameの属性しか持っていないこと" do
      expect(
        assigns(:result).all?{|obj| obj.class.to_s == "City" && obj.attributes.keys == ["id", "name"] }
      ).to eq true
    end
  end

  describe "exercise4" do
    before { get :exercise4 }
    it "渋谷区の全てのshopを返すこと" do
      expect(
        assigns(:result) ==
          Shop.all.select{|shop| shop.city_id == City.find{|city| city.name == "渋谷区" }.id }
      ).to eq true
    end
    it "Cityのアソシエーションメソッドを使って取得していること" do
      expect(
        assigns(:result).class.to_s == "Shop::ActiveRecord_Associations_CollectionProxy"
      ).to eq true
    end
  end

  describe "exercise5" do
    before { get :exercise5 }
    it "user_idが1のuserが注文した全ての料理(food)を返すこと" do
      user1_orders_ids =
        Order.select{|order| order.user_id == 1 }.map(&:id)
      user1_foods_ids =
        OrderFood.select{|order_food| user1_orders_ids.include?(order_food.order_id) }.map(&:food_id)
      expect(
        assigns(:result) == Food.select{|x| user1_foods_ids.include? x.id }
      ).to eq true
    end
    it "ActiveRecord::Base#joinsを使っていること" do
      actual_methods(assigns(:query)).any?{|x| x.include?("joins")}
    end
    it "ActiveRecord::Base#whereを使っていること" do
      actual_methods(assigns(:query)).any?{|x| x.include?("where")}
    end
    it "@resultのクラスは、Food::ActiveRecord_Relationであること(ActiveRecordのメソッドのみを使っていること)" do
      expect(
        assigns(:result).class.to_s == "Food::ActiveRecord_Relation"
      ).to eq true
    end
  end

  describe "exercise6" do
    before { get :exercise6 }
    it "user_idが1のuserが注文した料理(food)の合計金額を返すこと" do
      user1_orders_ids =
        Order.select{|order| order.user_id == 1 }.map(&:id)
      user1_foods_ids =
        OrderFood.select{|order_food| user1_orders_ids.include?(order_food.order_id) }.map(&:food_id)
      expect(
        assigns(:result) == Food.select{|food| user1_foods_ids.include?(food.id) }.map(&:price).sum
      ).to eq true
    end
    it "ActiveRecord::Base#joinsを使っていること" do
      actual_methods(assigns(:query)).any?{|x| x.include?("joins")}
    end
    it "ActiveRecord::Base#whereを使っていること" do
      actual_methods(assigns(:query)).any?{|x| x.include?("where")}
    end
    it "ActiveRecord::Base#sumを使っていること" do
      actual_methods(assigns(:query)).any?{|x| x.include?("sum")}
    end
  end

  describe "exercise7" do
    before { get :exercise7 }
    it "全てのuserとそのuserの注文数を返すこと" do
      #  @resultが内包する全てのオブジェクトのクラスはUserであり、
      #  それらのオブジェクトはorders_countという属性を持ち、それがそのuserの注文数を表していること
      result = assigns(:result).all? do |user|
        user.class.to_s == "User" &&
          user.attributes.has_key?("orders_count") &&
          user.orders_count == user.orders.map{|x| x.foods }.flatten.size
      end
      expect(result).to eq true
    end
    it "ActiveRecord::Base#left_outer_joinsを使っていること" do
      actual_methods(assigns(:query)).any?{|x| x.include?("left_outer_joins")}
    end
    it "ActiveRecord::Base#distinctを使っていること" do
      actual_methods(assigns(:query)).any?{|x| x.include?("distinct")}
    end
    it "ActiveRecord::Base#selectを使っていること" do
      actual_methods(assigns(:query)).any?{|x| x.include?("select")}
    end
    it "ActiveRecord::Base#groupを使っていること" do
      actual_methods(assigns(:query)).any?{|x| x.include?("group")}
    end
    it "@resultのクラスは、User::ActiveRecord_Relationであること(ActiveRecordのメソッドのみを使っていること)" do
      expect(
        assigns(:result).class.to_s == "User::ActiveRecord_Relation"
      ).to eq true
    end
  end

  describe "exercise8" do
    before { get :exercise8 }
    it "全てのuserとそのuserの注文した料理の合計金額を合計金額の降順で返すこと" do
      #  @resultが内包する全てのオブジェクトのクラスはUserであり、
      #  それらのオブジェクトはtotal_priceという属性を持ち、それがそのuserの注文した料理の合計金額を表していること
      result = assigns(:result).all? do |user|
        user.class.to_s == "User" &&
          user.attributes.has_key?("total_price") &&
          user.total_price == user.orders.map{|x| x.foods }.flatten.sum(&:price)
      end
      expect(result).to eq true
    end
    it "ActiveRecord::Base#joinsを使っていること" do
      actual_methods(assigns(:query)).any?{|x| x.include?("joins")}
    end
    it "ActiveRecord::Base#selectを使っていること" do
      actual_methods(assigns(:query)).any?{|x| x.include?("select")}
    end
    it "ActiveRecord::Base#groupを使っていること" do
      actual_methods(assigns(:query)).any?{|x| x.include?("group")}
    end
    it "ActiveRecord::Base#orderを使っていること" do
      actual_methods(assigns(:query)).any?{|x| x.include?("order")}
    end
    it "@resultのクラスは、User::ActiveRecord_Relationであること(ActiveRecordのメソッドのみを使っていること)" do
      expect(
        assigns(:result).class.to_s == "User::ActiveRecord_Relation"
      ).to eq true
    end
  end

  describe "exercise9" do
    before { get :exercise9 }
    it "注文した料理の合計金額の多いuserのトップ5を返すこと" do
      user_and_orders =
        Order.all.reject do |order|
            order.user_id.nil?
        end.
        group_by do |order|
          User.all.select{|user| user == order.user }
        end

      user_and_foods =
        user_and_orders.map do |user, orders|
          [
            user,
            orders.map do |order|
              Food.find(
                OrderFood.all.find_by_order_id(order.id).food_id
              )
            end
          ]
        end.to_h

      user_and_total_prices =
        user_and_foods.map do |user, foods|
          [
            user,
            foods.sum(&:price)
          ]
        end
        
      top_5_users =
        user_and_total_prices.sort{|a, b| b[1] <=> a[1] }.first(5).map{|user, price| user }.flatten

      expect(assigns(:result)).to match top_5_users
    end
    it "ActiveRecord::Base#joinsを使っていること" do
      actual_methods(assigns(:query)).any?{|x| x.include?("joins")}
    end
    it "ActiveRecord::Base#whereを使っていること" do
      actual_methods(assigns(:query)).any?{|x| x.include?("where")}
    end
    it "ActiveRecord::Base#selectを使っていること" do
      actual_methods(assigns(:query)).any?{|x| x.include?("select")}
    end
    it "ActiveRecord::Base#groupを使っていること" do
      actual_methods(assigns(:query)).any?{|x| x.include?("group")}
    end
    it "ActiveRecord::Base#orderを使っていること" do
      actual_methods(assigns(:query)).any?{|x| x.include?("order")}
    end
    it "@resultのクラスは、User::ActiveRecord_Relationであること(ActiveRecordのメソッドのみを使っていること)" do
      expect(
        assigns(:result).class.to_s == "User::ActiveRecord_Relation"
      ).to eq true
    end
  end

  describe "exercise10" do
    subject(:action) { get :exercise10 }
    it { is_expected.to have_http_status(:ok) }
    context "selectの引数以外は変更していないこと" do
      before { subject }
      it "Userのクラスオブジェクトに対してメッセージを投げていること" do
        expect(
          assigns(:query).slice(0,4) == "User"
        ).to  eq true
      end
      it "1番目のメソッドはfirstであること" do
        expect(
          actual_methods(assigns(:query))[0] == "first"
        ).to eq true
      end
      it "2番目のメソッドはordersであること" do
        expect(
          actual_methods(assigns(:query))[1] == "orders"
        ).to eq true
      end
      it "3番目のメソッドはselectであること" do
        expect(
          actual_methods(assigns(:query))[2].slice(0, 6) == "select"
        ).to eq true
      end
      it "最後から2番目のメソッドはlastであること" do
        len = actual_methods(assigns(:query)).size
        expect(
          actual_methods(assigns(:query))[len - 2] == "last"
        ).to eq true
      end
      it "最後のメソッドはuser_idであること" do
        len = actual_methods(assigns(:query)).size
        expect(
          actual_methods(assigns(:query))[len - 1] == "user_id"
        ).to eq true
      end
    end
  end

  describe "exercise11" do
    before { get :exercise11 }
    it "名前に'a'が含まれる全てのuserを返すこと" do
      expect(
        assigns(:result)
      ).to match User.all.select{|user| user.name.include?("a") }
    end
    it "ActiveRecord::Base#whereを使っていること" do
      actual_methods(assigns(:query)).any?{|x| x.include?("where")}
    end
    it "@resultのクラスは、User::ActiveRecord_Relationであること(ActiveRecordのメソッドのみを使っていること)" do
      expect(
        assigns(:result).class.to_s == "User::ActiveRecord_Relation"
      ).to eq true
    end
  end

  describe "exercise12" do
    before { get :exercise12 }
    it "userのidが5から10のuserを返すこと" do
      expect(
        assigns(:result).ids
      ).to match [5, 6, 7, 8, 9, 10]
    end
    it "ActiveRecord::Base#whereを使っていること" do
      actual_methods(assigns(:query)).any?{|x| x.include?("where")}
    end
    it "@resultのクラスは、User::ActiveRecord_Relationであること(ActiveRecordのメソッドのみを使っていること)" do
      expect(
        assigns(:result).class.to_s == "User::ActiveRecord_Relation"
      ).to eq true
    end
  end

  private

  def actual_methods(assigned_query)
    assigned_query.chomp.split(".").select.with_index{|str, i| i != 0 }
  end

end

DatabaseCleaner.clean
