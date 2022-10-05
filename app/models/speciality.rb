class Speciality < ApplicationRecord

  has_many :profile

  
  # validates :name, length: { maximum: 255 }, uniqueness: true

end
