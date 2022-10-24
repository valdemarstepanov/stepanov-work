class Profile < ApplicationRecord

  belongs_to :speciality
  belongs_to :grade
  belongs_to :user
  has_one :pool, dependent: :destroy

  validates :first_name, :last_name, :grade_id, :speciality_id, presence: true
  
end
