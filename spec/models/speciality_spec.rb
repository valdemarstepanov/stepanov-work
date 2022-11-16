require 'rails_helper'

RSpec.describe Speciality, type: :model do

  it { is_expected.to validate_length_of(:name).is_at_most(255) }
  it { is_expected.to validate_uniqueness_of(:name) }

  it { is_expected.to have_many(:profile) }

  it { should respond_to(:name) }
end
