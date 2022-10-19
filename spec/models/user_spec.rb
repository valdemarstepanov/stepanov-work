require 'rails_helper'

RSpec.describe User, type: :model do
  
    it { is_expected.to have_one(:profile) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }

end
