require 'securerandom'

class SnapshotsController < BaseController

  def create 
    snapshot_parent = Pool.find_by parent_id: nil
    # snapshot_parent = Pool.root_for_pool
    # binding.pry
    @snapshot = snapshot_parent.create_snapshot!("#{snapshot_parent.profile.first_name} #{snapshot_parent.profile.last_name}, #{Time.new}")
    if @snapshot.save
      redirect_to root_path, notice: t('controllers.snapshots_controller.create.flash.notice')
    else
      redirect_to root_path, alert: t('controllers.snapshots_controller.create.flash.alert')
    end
  end

  def show
    @snapshot = ActiveSnapshot::Snapshot.find(params[:id])
  end

  def snapshot_graph
    snapshot = ActiveSnapshot::Snapshot.find(params[:snapshot_id])
    reified_parent, reified_children_hash = snapshot.fetch_reified_items

    result = []
    result << reified_parent
    reified_children_hash['descendants'].each_with_index do |child, i|
      child.profile = reified_children_hash['descendants_profiles'][i]
      result << child
    end
    File.open("/tmp/test.dot", "w") { |f| f.write(Pool.to_dot_digraph(result, current_user.profile.id)) }
    GraphViz.parse( "/tmp/test.dot", :path => "/" ).output(:png => "/tmp/test3.png")
    # binding.pry
    # send_file Rails.root.join('/public/assets/graph1-788b1a6dc7718d4a8117dde2a1d3c413e5aa6763235594f26908cecc4756970f.png'), :type  =>  'image/png', :disposition  =>  'inline'
    send_file File.open(Rails.root.join('/tmp/test3.png'), 'r')
  end
end
