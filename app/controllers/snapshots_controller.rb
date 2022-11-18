class SnapshotsController < BaseController

  def index
    @snapshots = ActiveSnapshot::Snapshot.all.page(params[:page]).per(5)
  end
  
  def show
    @snapshots = ActiveSnapshot::Snapshot.all.page(params[:page]).per(5)
    @snapshot = ActiveSnapshot::Snapshot.find(params[:id])
  end

  def create
    pool_parent = Pool.find(params[:root_id])
    snapshot = pool_parent.create_snapshot!("Time: #{Time.new}
      Creator: #{current_user.profile.first_name} #{current_user.profile.last_name}")
    if snapshot.save
      redirect_to root_path, notice: t('controllers.snapshots_controller.create.flash.notice')
    else
      redirect_to root_path, alert: t('controllers.snapshots_controller.create.flash.alert')
    end
  end

  def snapshot_graph
    snapshot = ActiveSnapshot::Snapshot.find(params[:snapshot_id])
    restore = ::SnapshotRestore.new.call(snapshot)
    send_file ::GraphGenerator.new.call(restore, current_user.profile.id)
  end
end
