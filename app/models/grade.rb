class Grade < ApplicationRecord

    has_one :profile

    validates :name, uniqueness: true

end
