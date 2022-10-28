class Pool < ApplicationRecord
  before_destroy :change_parent_pools

  belongs_to :profile
  
  has_closure_tree

  validates :type, presence: true

  def to_digraph_label
    "#{profile.first_name} #{profile.last_name} / #{type}"
  end

  def change_parent_pools
    pools_for_update = Pool.where(parent_id: profile.pool.id)
    pools_for_update.each {|pool| pool.update(parent_id: profile.pool.parent_id)}
  end

end
