class Speciality < ApplicationRecord

  belongs_to :profile

  validates :name, length: { maximum: 25 }, uniqueness: true

end
