class Speciality < ApplicationRecord

  has_many :profile, dependent: :restrict_with_error

  validates :name, length: { maximum: 255 }, uniqueness: true

end
