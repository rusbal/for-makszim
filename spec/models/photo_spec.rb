require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe 'associations' do
    it { should belong_to(:album) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
