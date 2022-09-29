require 'rails_helper'

RSpec.describe Speciality, type: :model do
  
  describe 'with validations' do
    it { is_expected.to validate_length_of(:name).is_at_most(25) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end