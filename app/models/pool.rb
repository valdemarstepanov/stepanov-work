class Pool < ApplicationRecord

  has_many :profile
  
  has_closure_tree
  
end
