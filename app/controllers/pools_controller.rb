class PoolsController < BaseController

  def index
    @pools = policy_scope(Pool).includes(profile: :user).order(parent_id: :asc).page(params[:page]).per(5)
    @pool_root = policy_scope(Pool).root
    
    @select_parents = Pool.includes(:profile).decorate.map { |pool| [pool.full_name_and_grade, pool.id] }
    @select_children = Profile.where.not(id: Pool.pluck(:profile_id)).decorate.map do |profile|
      [profile.full_name_and_grade, profile.id]
    end
  end

  def create
    @pool = Pool.create(pool_params)
    
    if authorize @pool, policy_class: PoolPolicy
      @pool.save!
      redirect_to root_path, notice: t('controllers.pools_controller.create.flash.notice')
    else
      redirect_to root_path, alert: t('controllers.application_controller.user_not_authorized.flash.alert')
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
    @pools = Pool.includes(:profile)
    send_file ::GraphGenerator.new.call(@pools, current_user.profile.id)
  end

  private

  def pool_params
    params.require(:pool).permit(:id, :type, :profile_id, :parent_id)
  end
end
