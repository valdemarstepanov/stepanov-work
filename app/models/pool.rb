class Pool < ApplicationRecord

  belongs_to :profile
  
  has_closure_tree
  
  validates :profile_id, uniqueness: true
  validates :type, presence: true
end
