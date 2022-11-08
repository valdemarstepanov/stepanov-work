class SnapshotsController < BaseController

  def create
    
    time = Time.new

    snapshot_parent = Pool.find_by parent_id: nil
    snapshot = snapshot_parent.create_snapshot!(time)
    reified_parent, reified_children_hash = snapshot.fetch_reified_items
     # binding.pry

    end
end
  