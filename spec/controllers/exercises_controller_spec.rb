require 'rails_helper'

RSpec.describe ExercisesController, type: :controller do
  describe "exercise1" do
    let(:foods) { Food.where.not(id: OrderFood.pluck(:food_id).uniq) }
    before do
      expect(Food).to receive(:left_outer_joins).and_call_original
      get :exercise1
    end
    it "注文されていないすべての料理を返すこと" do
      expect(assigns(:foods)).to match_array foods
    end
    it "@foodsのクラスは'Food::ActiveRecord_Relation'であること" do
      expect(assigns(:foods).class.to_s).to eq "Food::ActiveRecord_Relation"
    end
  end

  describe "exercise2" do
    let(:foods) { Food.where.not(id: OrderFood.pluck(:food_id).uniq) }
    let(:shops) { Shop.all.select{|shop| shop.foods.any?{|food| foods.include?(food) } } }
    before do
      expect(Shop).to receive(:left_outer_joins).and_call_original
      get :exercise2
    end
    it "注文されていない料理を提供しているすべてのお店を返すこと" do
      expect(assigns(:shops)).to match_array shops
    end
    it "@shopsのクラスは'Shop::ActiveRecord_Relation'であること" do
      expect(assigns(:shops).class.to_s).to eq "Shop::ActiveRecord_Relation"
    end
  end

  describe "exercise3" do
    let(:address) { Address.all.sort{|a, b| b.orders.size <=> a.orders.size }.first }
    before do
      expect(Address).to receive(:joins).and_call_original
      get :exercise3
    end
    it "配達先の一番多い住所を返すこと" do
      expect(assigns(:address)).to eq address
    end
    it "@addressにorders_countと呼びかけると注文の数を返すこと" do
      expect(assigns(:address).orders_count).to eq address.orders.size
    end
  end

  describe "exercise4" do
    let(:customer) {
      Customer.module_eval { def foods_price_sum; orders.map(&:foods).flatten.sum(&:price); end }
      Customer.all.sort{|a, b| b.foods_price_sum <=> a.foods_price_sum }.first
    }
    before do
      expect(Customer).to receive(:joins).and_call_original
      get :exercise4
    end
    it "一番お金を使っている顧客を返すこと" do
      expect(assigns(:customer)).to eq customer
    end
    it "@customerにfoods_price_sumとと呼びかけると合計金額を返すこと" do
      expect(assigns(:customer).foods_price_sum).to eq customer.foods_price_sum
    end
  end

end