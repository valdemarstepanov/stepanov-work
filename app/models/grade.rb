class Grade < ApplicationRecord

    has_many :profile

    validates :name, uniqueness: true

end
