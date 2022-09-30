class Profile < ApplicationRecord

    belongs_to :speciality
    belongs_to :grade
    belongs_to :user
    
end
