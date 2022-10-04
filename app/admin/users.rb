ActiveAdmin.register User do
  permit_params :id, :email, :password, :password_confirmation, role_ids: [], 
  profile_attributes: [:user_id, :grade_id, :speciality_id, :first_name, :last_name],
  grade_attributes: [:id, :name, :level], speciality_attributes: [:id, :name]

  index do
    id_column
    column :profile
    column :first_name
    column :last_name
    column :email
    column :grade
    column :speciality
    column :roles
    actions
  end

  filter :email

  show do
    attributes_table do
      
      row :profile
      row :first_name
      row :last_name
      row :email
      # row :name, for: [:grade]
      # row :level, for: [:grade]
      # row :name, for: [:speciality]
      row :roles
    end
  end


  # controller do
  #   def create
  #     @profile = Profile.create(profile_params)
  #   end

  #   def profile_params
  #     params.require(:profile).permit(:id, :user_id, :grade_id, :speciality_id, :first_name, :last_name)
  #   end
  # end



  form do |f|

    f.inputs "Profile", for: [:profile, f.object.profile || Profile.create] do |p|
      p.input :first_name
      p.input :last_name
    end

    f.inputs "Grade", for: [:grade, f.object.grade || Grade.create] do |p|
      p.input :name
      p.input :level
    end

    f.inputs "Speciality", for: [:speciality, f.object.grade|| Speciality.create] do |p|
      p.input :name
    end

    # f.inputs "Grade", for: [:grade, f.object.profile || Grade.create]
    # f.inputs "Speciality", for: [:speciality, f.object.profile || Speciality.create]   

    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :roles, :as => :select, :collection => Role.global
    end
    f.actions
  end
end
