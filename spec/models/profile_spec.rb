require 'rails_helper'

RSpec.describe Profile, type: :model do

    it { is_expected.to have_one(:speciality) }
    it { is_expected.to have_one(:grade) }

end
