class PoolsController < BaseController
  before_action :authenticate_user!
  
  def index
    @pools = Pool.order(parent_id: :asc)
  end

  def new
    @pool = Pool.new
  end
    
  def create
    @pool = Pool.create(pool_params)
    if @pool.save
      redirect_to root_path, notice: t('controllers.pools_controller.create.flash.notice')
    else
      redirect_to new_pool_path, alert: t('controllers.pools_controller.create.flash.alert')
    end
  end

  def destroy
    @pool = Pool.find(params[:id])
    @pool.destroy
    redirect_to root_path, notice: t('controllers.pools_controller.destroy.flash.notice')
  end

  private

  def pool_params
    params.require(:pool).permit(:id, :type, :profile_id, :parent_id)
  end
end
