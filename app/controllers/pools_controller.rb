class PoolsController < BaseController

  def index

    if current_user.has_role? :manager || Pool.find_by(id: current_user.profile.id).present?
    
    @pools = Pool.where(pool_container_id: current_user.pool_container.id).includes(profile:
      [:user, :grade, :speciality]).order(parent_id: :asc).page(params[:page]).per(5)
    @pool_root = Pool.where(pool_container_id: current_user.pool_container.id).root
    
    @select_parents = Pool.where(pool_container_id: current_user.pool_container.id).includes(:profile,
       [profile: :grade]).decorate.map { |pool| [pool.full_name_and_grade, pool.id] }
    @select_children = Profile.includes(:grade).where.not(id: Pool.pluck(:profile_id)).decorate.map do |profile|
      [profile.full_name_and_grade, profile.id]
    end
    end
  end

  def show
    @pools = policy_scope(Pool).includes(profile: [:user, :grade, :speciality]).order(parent_id: :asc).page(params[:page]).per(5)
    @pool_root = policy_scope(Pool).root
    
    @select_parents = Pool.includes(:profile, [profile: :grade]).decorate.map { |pool| [pool.full_name_and_grade, pool.id] }
    @select_children = Profile.includes(:grade).where.not(id: Pool.pluck(:profile_id)).decorate.map do |profile|
      [profile.full_name_and_grade, profile.id]
    end
  end

  def create
    
    params = pool_params.merge(pool_container_id: current_user.pool_container.id)

    @pool = Pool.create(params)

    authorize @pool, policy_class: PoolPolicy
    if @pool.save!
      redirect_to root_path, notice: t('controllers.pools_controller.create.flash.notice')
    else
      redirect_to root_path, alert: t('controllers.pools_controller.create.flash.alert')
    end
  end

  def destroy
    @pool = Pool.find(params[:id])

    authorize @pool, policy_class: PoolPolicy

    if @pool.parent_id.present?
      @pool.destroy!
      redirect_to root_path, notice: t('controllers.pools_controller.destroy.flash.notice')
    else
      redirect_to root_path, alert: t('controllers.pools_controller.destroy.flash.alert')
    end
  end

  def pool_graph
    if current_user.has_role? :manager
    @pools = Pool.where(pool_container_id: current_user.pool_container.id).includes(:profile)
    else
      pool = Pool.find_by(profile_id: current_user.profile.id)
      if pool.present?
        @pools = Pool.where(pool_container_id: pool.pool_container.id)
      end
    end
    send_file ::GraphGenerator.new.call(@pools, current_user.profile.id)
  end

  private

  def pool_params
    params.require(:pool).permit(:id, :type, :profile_id, :parent_id)
  end
end
