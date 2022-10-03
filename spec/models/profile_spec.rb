require 'rails_helper'

RSpec.describe Profile, type: :model do

    it { is_expected.to belong_to(:speciality) }
    it { is_expected.to belong_to(:grade) }
    it { is_expected.to belong_to(:user) }

end
