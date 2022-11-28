class User < ApplicationRecord
  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_one :profile
  has_one :pool_container
  

  after_save :create_pool_container

  def create_pool_container

    user = User.last

    if user.has_role? :manager
      PoolContainer.create(user_id: user.id)
    end
  end
end
