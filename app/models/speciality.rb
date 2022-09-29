class Speciality < ApplicationRecord

  validates :name, length: { maximum: 25 }, uniqueness: true

end
