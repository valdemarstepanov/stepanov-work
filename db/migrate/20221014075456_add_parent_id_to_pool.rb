class AddParentIdToPool < ActiveRecord::Migration[7.0]
  def change
    add_column :pools, :parent_id, :integer
  end
end
