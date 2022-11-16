require 'rails_helper'

RSpec.describe Grade, type: :model do
  
  it { is_expected.to have_many(:profile) }

  it { is_expected.to validate_uniqueness_of(:name) }

  it { should respond_to(:name) }
  it { should respond_to(:level) }
end
