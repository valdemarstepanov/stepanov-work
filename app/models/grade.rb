class Grade < ApplicationRecord

  has_many :profile, dependent: :restrict_with_error

  validates :name, uniqueness: true

end
