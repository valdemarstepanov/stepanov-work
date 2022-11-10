class ProfileDecorator < ApplicationDecorator
  delegate_all
  
  def full_name
    "#{profile.first_name} #{profile.last_name}"
  end
end
  