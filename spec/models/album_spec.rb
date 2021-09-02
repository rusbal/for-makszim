require 'rails_helper'

RSpec.describe Album, type: :model do
  describe 'associations' do
    it { should have_many(:photos).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
