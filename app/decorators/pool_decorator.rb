class PoolDecorator < ApplicationDecorator
  delegate_all

  def full_name
    "#{profile.first_name} #{profile.last_name}"
  end

  def full_grade
    "#{profile.grade.name} #{profile.grade.level}"
  end

end
