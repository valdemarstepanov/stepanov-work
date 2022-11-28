class PoolContainer < ApplicationRecord
    
    has_many :pools
    belongs_to :user
    
    validates :user_id, presence: true
end
