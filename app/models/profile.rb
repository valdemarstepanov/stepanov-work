class Profile < ApplicationRecord

    belongs_to :speciality
    belongs_to :grade
    belongs_to :user

    # accepts_nested_attributes_for :speciality, :grade, :user
    # validates :first_name, :last_name, :user_id, presence: true
end
