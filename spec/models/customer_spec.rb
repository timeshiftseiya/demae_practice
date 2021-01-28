require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "associations" do
    it { should have_many(:addresses) }
    it { should have_many(:orders) }
  end
end
