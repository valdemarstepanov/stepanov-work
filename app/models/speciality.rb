class Speciality < ApplicationRecord

  has_many :profile
  accepts_nested_attributes_for :profile

  # validates :name, length: { maximum: 255 }, uniqueness: true

end
