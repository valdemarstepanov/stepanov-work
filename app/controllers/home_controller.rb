class HomeController < ApplicationController
  before_action :authenticate_user!
    
  def index
    @pool = Pool.all
  end

end
