require 'rails_helper'

RSpec.describe Grade, type: :model do
  
  describe 'with validations' do
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end