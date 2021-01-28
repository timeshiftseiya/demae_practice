require 'rails_helper'

RSpec.describe ChineseFood, type: :model do
  describe "associations" do
    it { should belong_to(:shop) }
    it { should have_many(:order_foods) }
    it { should have_many(:orders).through(:order_foods) }
  end
end
