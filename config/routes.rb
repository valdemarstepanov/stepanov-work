Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  devise_for :user, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  root to: "home#index"

end
