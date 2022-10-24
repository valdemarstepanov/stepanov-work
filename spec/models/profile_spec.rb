require 'rails_helper'

RSpec.describe Profile, type: :model do

    it { is_expected.to belong_to(:speciality) }
    it { is_expected.to belong_to(:grade) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_one(:pool) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:grade_id) }
    it { is_expected.to validate_presence_of(:speciality_id) }
    xit { is_expected.to validate_presence_of(:user_id) }

end
