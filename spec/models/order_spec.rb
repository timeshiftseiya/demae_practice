require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "associations" do
    it { should belong_to(:address) }
    it { should belong_to(:customer) }
    it { should have_many(:order_foods) }
    it { should have_many(:foods).through(:order_foods) }
  end
end
