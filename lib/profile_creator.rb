class ProfileCreator

  def call(params)

    ActiveRecord::Base.transaction do
  
      user_params = params.require(:profile).require(:user_attributes).permit(:id, :email, :password, :password_confirmation)
      user = User.create!(user_params)

      if params[:profile][:user_attributes][:role_ids] == ["", "1"]
        user.add_role :manager
      else
        user.add_role :user
      end

      if params[:profile][:grade_id].present?
        grade = Grade.find(params[:profile][:grade_id])
      else
        grade = Grade.find_by(name: params[:profile][:grade_attributes][:name],
        level: params[:profile][:grade_attributes][:level])
      end

      if grade.blank?

        grade_params = params.require(:profile).require(:grade_attributes).permit(:id, :name, :level)
        grade = Grade.create(grade_params)

      end

      if params[:profile][:speciality_id].present?
        speciality = Speciality.find(params[:profile][:speciality_id])
      else
        speciality = Speciality.find_by(name: params[:profile][:speciality_attributes][:name])
      end

      if speciality.blank?

        speciality_params = params.require(:profile).require(:speciality_attributes).permit(:id, :name)
        speciality = Speciality.create!(speciality_params)

      end

      profile = Profile.create!(first_name: params[:profile][:first_name], last_name: params[:profile][:last_name],
        user_id: user.id, grade_id: grade.id, speciality_id: speciality.id)

    end
  end
end
