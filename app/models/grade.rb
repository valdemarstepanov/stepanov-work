class Grade < ApplicationRecord

    belongs_to :profile

    validates :name, uniqueness: true

end
