class ProfileCreatorService

  def create_profile(params)

    ActiveRecord::Base.transaction do

      user =
        User.create!(
          email: params[:profile][:user_attributes][:email],
          password: params[:profile][:user_attributes][:password],
          password_confirmation: params[:profile][:user_attributes][:password_confirmation]
        )

      binding.pry
      # if params[:profile][:user_attributes][:role_ids] == ["", "1"]
      #   user.add_role :manager
      # else
      #   user.add_role :user
      # end

      grade = find_grade(params)
      
      if grade.blank?
        grade =
          Grade.create!(
            name: params[:profile][:grade_attributes][:name],
            level: params[:profile][:grade_attributes][:level]
          )
      end

      speciality = find_speciality(params)

      if speciality.blank?
        speciality = Speciality.create!(name: params[:profile][:speciality_attributes][:name])
      end

      profile =
        Profile.create!(
          first_name: params[:profile][:first_name],
          last_name: params[:profile][:last_name],
          user_id: user.id,
          grade_id: grade.id,
          speciality_id: speciality.id
        )
    end
  end

  private

  def find_grade(params)
    if params[:profile][:grade_id].present?
      grade =
        Grade.find_by(id: params[:profile][:grade_id])
    else
        Grade.find_by(
          name: params[:profile][:grade_attributes][:name],
          level: params[:profile][:grade_attributes][:level]
        )
    end
  end

  def find_speciality(params)
    if params[:profile][:speciality_id].present?
      speciality =
        Speciality.find_by(id: params[:profile][:speciality_id])
    else
        Speciality.find_by(name: params[:profile][:speciality_attributes][:name])
    end
  end
end
