require 'rails_helper'

RSpec.describe Grade, type: :model do
  
    it { is_expected.to have_one(:profile) }
    it { is_expected.to validate_uniqueness_of(:name) }

end
