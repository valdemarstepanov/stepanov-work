class PoolsController < ApplicationController
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
      flash[:notice] = 'Succes! New pool is created!'
      redirect_to root_path
    else
      flash[:alert] = 'Error! New pool is not created!'
      redirect_to new_pool_path
    end
  end

  def destroy
    @pool = Pool.find(params[:id])
    @pool.destroy
    flash[:notice] = 'Pool deleted!'
    redirect_to root_path
  end

  private

  def pool_params
    params.require(:pool).permit(:id, :type, :profile_id, :parent_id)
  end
end
