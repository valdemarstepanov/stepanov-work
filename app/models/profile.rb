class Profile < ApplicationRecord

  belongs_to :speciality
  belongs_to :grade
  belongs_to :user
  has_one :pool

  validates :first_name, :last_name, :grade_id, :speciality_id, :user_id, presence: true
  accepts_nested_attributes_for :user, :grade, :speciality

  scope :available_profile, -> {
    where.not(id: Pool.pluck(:profile_id)).decorate.map do |profile|
      [profile.full_name_and_grade, profile.id]
    end
  }
end
