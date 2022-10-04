class Grade < ApplicationRecord

    has_many :profile
    accepts_nested_attributes_for :profile

    # validates :name, uniqueness: true
    # validates :name, :level, presence: true

end
