require 'rails_helper'

RSpec.describe Shop, type: :model do
  describe "associations" do
    it { should have_many(:addresses) }
    it { should have_many(:foods) }
  end
end
