class Grade < ApplicationRecord

    validates :name, uniqueness: true

end
