ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, role_ids: [], 
  profile_attributes: [:id, :first_name, :last_name, :grade_id, :speciality_id]
  
  index do
    id_column
    column(:First_name) { |user| user.profile.first_name }
    column(:Last_name) { |user| user.profile.last_name }
    column(:Grade_name) { |user| user.profile.grade.name }
    column(:Grade_level) { |user| user.profile.grade.level }
    column(:Speciality) { |user| user.profile.speciality }
    column :email
    column :roles
    actions
  end

  show do
    attributes_table do
      row(:First_name) { |user| user.profile.first_name }
      row(:Last_name) { |user| user.profile.last_name }
      row(:Grade_name) { |user| user.profile.grade.name }
      row(:Grade_level) { |user| user.profile.grade.level }
      row(:Speciality) { |user| user.profile.speciality }
      row :email
      row :roles
    end
  end

  filter :email
  
  form do |f|
    f.semantic_errors *f.object.errors.attribute_names
    f.inputs 'User' do
      f.input :email
      f.input :roles
      f.input :password
      f.input :password_confirmation
    end

    f.inputs "Profile", for: [:profile, f.object.profile || Profile.create] do |p|
      p.input :first_name
      p.input :last_name
      p.input :grade
      p.input :speciality
    end
    f.actions
  end
end
