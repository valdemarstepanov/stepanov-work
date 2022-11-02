class PoolsController < BaseController
  before_action :authenticate_user!
  
  def index
    @pools = policy_scope(Pool).includes(profile: :user).order(parent_id: :asc)
    ::GraphGenerator.new.call(@pools, current_user.profile.id) if @pools.present?
  end

  def new
    @pool = Pool.new

  end

  def show
    # date = params[:date]
    # pool = Pool.find(params[:id])
    # pool.paper_trail.version_at(date)
    # binding.pry
    @pools = Pool.includes(:profile)
    ::GraphGenerator.new.call(@pools, current_user.profile.id) if @pools.present?
  end

  def create
    @pool = Pool.create(pool_params)

    authorize @pool, policy_class: PoolPolicy

    if @pool.save
      redirect_to root_path, notice: t('controllers.pools_controller.create.flash.notice')
    else
      redirect_to root_path, alert: t('controllers.pools_controller.create.flash.alert')
    end
  end

  def destroy
    @pool = Pool.find(params[:id])

    authorize @pool, policy_class: PoolPolicy

    if @pool.destroy!
      redirect_to root_path, notice: t('controllers.pools_controller.destroy.flash.notice')
    else
      redirect_to root_path, alert: t('controllers.pools_controller.destroy.flash.alert')
    end
  end

  private

  def pool_params
    params.require(:pool).permit(:id, :type, :profile_id, :parent_id)
  end
end
