require 'rails_helper'

RSpec.describe Pool, type: :model do
    it { is_expected.to belong_to(:profile) }
    it { is_expected.to validate_presence_of(:type) }
end
