class Speciality < ApplicationRecord

  has_one :profile

  validates :name, length: { maximum: 255 }, uniqueness: true

end
