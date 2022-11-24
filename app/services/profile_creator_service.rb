class ProfileCreatorService

  def create_profile(params)

    ActiveRecord::Base.transaction do

      user =
        User.create!(
          email: params.dig(:profile, :user_attributes, :email),
          password: params.dig(:profile, :user_attributes, :password),
          password_confirmation: params.dig(:profile, :user_attributes, :password_confirmation)
        )

      role = find_role(params)
      user.add_role :"#{role.name}"

      grade = find_grade(params)
      
      if grade.blank?
        grade =
          Grade.create!(
            name: params.dig(:profile, :grade_attributes, :name),
            level: params.dig(:profile, :grade_attributes, :level)
          )
      end

      speciality = find_speciality(params)

      if speciality.blank?
        speciality = Speciality.create!(name: params.dig(:profile, :speciality_attributes, :name))
      end

      profile =
        Profile.create!(
          first_name: params.dig(:profile, :first_name),
          last_name: params.dig(:profile, :last_name),
          user_id: user.id,
          grade_id: grade.id,
          speciality_id: speciality.id
        )
    end
  end

  private

  def find_grade(params)
    if params.dig(:profile, :grade_id).present?
      grade =
        Grade.find_by(id: params.dig(:profile, :grade_id))
    else
        Grade.find_by(
          name: params.dig(:profile, :grade_attributes, :name),
          level: params.dig(:profile, :grade_attributes, :level)
        )
    end
  end

  def find_speciality(params)
    if params[:profile][:speciality_id].present?
      speciality =
        Speciality.find_by(id: params.dig(:profile, :speciality_id))
    else
        Speciality.find_by(name: params.dig(:profile, :speciality_attributes, :name))
    end
  end

  def find_role(params)
    role_id = params.dig(:profile, :user_attributes, :role_ids)
    role = Role.find_by(id: role_id)
  end
end
