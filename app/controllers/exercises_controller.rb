class ExercisesController < ApplicationController
  def exercise1
    # 【要件】user_idが1のuserの注文(order)件数を返すこと
    #  - Userのアソシエーションメソッドを使うこと
    #  - ActiveRecord::Base#findを使用すること
    #  - ActiveRecord::Base#countを使用すること
    @query = <<~EOS
      # ここに記述
    EOS
    @result = eval(@query.chomp)
  end

  def exercise2
    # 【要件】最後の注文(order)をしたuserの名前を返すこと
    @query = <<~EOS
      # ここに記述
    EOS
    @result = eval(@query.chomp)
  end

  def exercise3
    # 【要件】全てのcityのidとnameを返すこと
    #  - ActiveRecord::Baseのメソッドを使うこと
    #  - @resultが内包する全てのオブジェクトのクラスはCityであり、
    #    それらのオブジェクトはidとnameの属性しか持っていないこと
    @query = <<~EOS
      # ここに記述
    EOS
    @result = eval(@query.chomp)
  end

  def exercise4
    # 【要件】渋谷区の全てのshopを返すこと
    #  - Cityのアソシエーションメソッドを使うこと
    @query = <<~EOS
      # ここに記述
    EOS
    @result = eval(@query.chomp)
  end

  def exercise5
    # 【要件】user_idが1のuserが注文した全ての料理(food)を返すこと
    #  - ActiveRecord::Base#joinsを使用すること
    #  - ActiveRecord::Base#whereを使用すること
    @query = <<~EOS
      # ここに記述
    EOS
    @result = eval(@query.chomp)
  end

  def exercise6
    # 【要件】user_idが1のuserが注文した料理(food)の合計金額を返すこと
    #  - ActiveRecord::Base#joinsを使用すること
    #  - ActiveRecord::Base#whereを使用すること
    #  - ActiveRecord::Base#sumを使用すること
    @query = <<~EOS
      # ここに記述
    EOS
    @result = eval(@query.chomp)
  end

  def exercise7
    # 【要件】全てのuserとそのuserの注文した料理の合計金額を合計金額の降順で返すこと。
    #  - @resultが内包する全てのオブジェクトのクラスはUserであり、
    #    それらのオブジェクトはtotal_priceという属性を持ち、それがそのuserの注文した料理の合計金額を表していること
    #  - ActiveRecord::Base#joinsを使用すること
    #  - ActiveRecord::Base#selectを使用すること
    #  - ActiveRecord::Base#groupを使用すること
    #  - ActiveRecord::Base#orderを使用すること
    #  - ヒント: https://railsguides.jp/active_record_querying.html#left-outer-joins
    @query = <<~EOS
      # ここに記述
    EOS
    @result = eval(@query.chomp)
  end

  def exercise8
    # 【要件】selectの引数を修正し、エラーにならずにのuser_idを返すこと
    #  - selectの引数以外は変更しないこと
    #  - メソッドも追加しないこと
      # User.first.orders.select(:id).last.user_id
    @query = <<~EOS
      # ここに記述
    EOS
    @result = eval(@query.chomp)
  end

  def exercise9
    # 【要件】名前に"a"が含まれる全てのuserを返すこと
    #  - ActiveRecord::Base#whereを使用すること
    @query = <<~EOS
      # ここに記述
    EOS
    @result = eval(@query.chomp)
  end

  def exercise10
    # 【要件】userのidが5から10のuserを返すこと
    #  - ActiveRecord::Base#whereを使用すること
    @query = <<~EOS
      # ここに記述
    EOS
    @result = eval(@query.chomp)
  end

end