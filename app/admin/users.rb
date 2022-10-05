ActiveAdmin.register User do

  permit_params :id, :email, :profile_id, :password, :password_confirmation, role_ids: []
  # profile_attributes: [:user_id, :first_name, :last_name]
  # grade_attributes: [:id, :name, :level], 
  # speciality_attributes: [:id, :name]

  index do
    id_column
    # column (:Name) { |user| user.profile. }
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
      
      # row :profile
      row :first_name
      row :last_name
      row :email
      row :name, for: [:grade]
      row :level, for: [:grade]
      row :name, for: [:speciality]
      row :roles
    end
  end

  form do |f|

    f.inputs do
      # f.input :first_name
      # f.input :last_name
      # f.input :grade_name
      # f.input :grade_level
      # f.input :speciality_name

      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :roles, :as => :select, :collection => Role.global
    end

    f.inputs "Profile", for: [:profile, f.object.profile || Profile.create] do |p|
      p.input :first_name
      p.input :last_name
    end

     f.inputs "Grade", for: [:grade, f.object.profile || Grade.create] do |p|
        p.input :name, :as => :select, :collection => Grade.all.collect {|grade| [grade.name] }
        p.input :level, :as => :select, :collection => Grade.all.collect {|grade| [grade.level] }
    end

    f.inputs "Speciality", for: [:speciality, f.object.profile || Speciality.create] do |p|
      p.input :name
    end
    f.actions
  end
end

# f.inputs do
#   f.input :name, :as => :select, :collection => Grade.all.collect {|grade| [grade.name] }
#   f.input :level, :as => :select, :collection => Grade.all.collect {|grade| [grade.level] }
# end

    # f.inputs "Grade", for: [:grade, f.object.profile || Grade.create] do |p|
    #   p.input :name
    #   p.input :level
    # end

    # f.inputs "Speciality", for: [:speciality, f.object.profile || Speciality.create] do |p|
    #   p.input :name
    # end

    # f.inputs "Grade", for: [:grade, f.object.profile || Grade.create]
    # f.inputs "Speciality", for: [:speciality, f.object.profile || Speciality.create]   

    # f.inputs do
    #   f.inputs "Profile"
    #   f.input :email
    #   f.input :password
    #   f.input :password_confirmation
    #   f.input :roles, :as => :select, :collection => Role.global
    # end
# end




    # controller do
    #     def create
          # @first_name = Profile.find(params[:profile][:first_name])
          # @last_name = Profile.find(params[:profile][:last_name])
          # @grade_name = Grade.find(params[:grade][:grade_name])
          # @grade_level = Grade.find(params[:grade][:grade_level])
          # @speciality_name = Speciality.find(params[:speciality][:speciality_name])

          
        #   params[:profile][:first_name ] = @first_name
        #   params[:profile][:last_name] = @last_name
        #   params[:grade][:grade_name] = @grade_name
        #   params[:grade][:grade_level] = @grade_level
        #   params[:speciality][:speciality_name] = @speciality_name
        #   @user = User.new(user_params)
        #   @grade = Grade.new(grade_params)
        #   @speciality = Speciality.new(speciality_params)
        #   @profile = Profile.new(profile_params)
        #   # super
        # end

        # def user_params
        #   params.require(:user).permit(:id, :email, :role, :user_id)
        # end

        # def grade_params
        #   params.require(:grade).permit(:id, :grade_name, :grade_level)
        # end


        # def speciality_params
        #   params.require(:speciality).permit(:id, :speciality_name)
        # end

        # def profile_params
        #   params.require(:profile).permit(:id, :user_id, :grade_id, :speciality_id, :first_name, :last_name)
        # end

    #   end
    # end


        #   f.inputs "Profile" do
    #     f.semantic_fields_for :profile do |p|
    #       p.input :first_name
    #       p.input :last_name
    #     end
    #   end
    #   f.inputs "Grade" do
    #     f.semantic_fields_for :grade do |p|
    #       p.input :grade_name
    #       p.input :grade_level
    #     end
    #   end

    #   f.inputs "Speciality" do
    #     f.semantic_fields_for :speciality do |p|
    #       p.input :speciality_name
    #     end
    #   end
    #   f.actions
    # end
