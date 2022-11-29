class CreateSnapshotService

  def create_snapshot(current_user)

    if current_user.pool_container.pools.count > 1
      pool_root = current_user.pool_container.pools.root
      pool_root.create_snapshot!(
        "Time: #{Time.new} Creator: #{current_user.profile.first_name} #{current_user.profile.last_name}",
        user: current_user
      )
    end
  end
end
