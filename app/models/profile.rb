class Profile < ApplicationRecord

    has_one :speciality, dependent: :destroy
    has_one :grade, dependent: :destroy

end
