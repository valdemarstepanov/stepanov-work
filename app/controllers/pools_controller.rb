class PoolsController < BaseController
  before_action :authenticate_user!
  
  def index
    @pools = policy_scope(Pool.includes([profile: :user])).order(parent_id: :asc)
    @pool_exist = @pools.exists?
    ::GraphGenerator.new.call(@pools) if @pool_exist
  end

  def new
    @pool = Pool.new
  end
    
  def create
    @pool = Pool.new(pool_params)
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
    unless @pool.parent_id.nil?
      @pool.destroy!
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
