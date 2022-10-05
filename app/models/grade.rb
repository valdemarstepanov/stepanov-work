class Grade < ApplicationRecord

    has_many :profile


    validates :name, uniqueness: true
    # validates :name, :level, presence: true

end
