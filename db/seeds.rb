require "csv"

ADDRESSES = CSV.foreach(
    "./lib/master_data/13tokyo.csv",
    encoding: "Shift_JIS:UTF-8",
    headers: true
  )
  .entries
  .reject{|address| address["字丁目"].blank? }

def random_address
  address = ADDRESSES.delete_at(rand(0..ADDRESSES.size)) # 重複しないように一度使ったら消す
  FactoryBot.build(
    :address,
    prefecture: address["都道府県"],
    city: address["市区町村"],
    line_1: address["町域"],
    line_2: address["字丁目"],
    postalcode: address["郵便番号"]
  )
end

def setup_shop
  shop = FactoryBot.create(:shop, name: Faker::Restaurant.unique.name)
  rand(1..3).times{ shop.addresses << random_address }
  rand(1..10).times do
    FactoryBot.create(
      "#{["japanese","chinese","italian"].sample}_food",
      shop: shop,
      name: "#{Faker::Creature::Animal.name}の#{Faker::Restaurant.type}",
      price: 300.step(by:100, to:1900).to_a.sample + 90
    )
  end
end

def setup_customer
  customer = FactoryBot.create(:customer, name: Faker::Name.unique.name)
  rand(1..3).times{ customer.addresses << random_address }
  rand(1..10).times do
    FactoryBot.create(
      :order,
      customer: customer,
      address: customer.addresses.sample
    )
  end
  customer.orders.each do |order|
    shop = Shop.all.sample
    rand(1..10).times do
      FactoryBot.create(
        :order_food,
        order: order,
        food: shop.foods.sample
      )
    end
  end
end

100.times do
  begin
    setup_shop
    setup_customer
  rescue => e
  end
end

# 要件で求める期待する出力結果を確実にするように
addr1, addr2 = Address.all.sort{|a, b| b.orders.size <=> a.orders.size }.first(2)
if addr1.orders.size == addr2.orders.size
  addr2.orders.last.destroy
end

Customer.module_eval { def foods_price_sum; orders.map(&:foods).flatten.sum(&:price); end }
c1, c2 = Customer.all.sort{|a, b| b.foods_price_sum <=> a.foods_price_sum }.first(2)
if c1.foods_price_sum == c2.foods_price_sum
  c2.orders.last.destroy
end