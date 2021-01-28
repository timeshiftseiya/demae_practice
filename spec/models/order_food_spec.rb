require 'rails_helper'

RSpec.describe OrderFood, type: :model do
  describe "associations" do
    it { should belong_to(:food) }
    it { should belong_to(:order) }
  end
end
