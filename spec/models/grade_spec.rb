require 'rails_helper'

RSpec.describe Grade, type: :model do
  
    it { is_expected.to belong_to(:profile) }
    it { is_expected.to validate_uniqueness_of(:name) }

end