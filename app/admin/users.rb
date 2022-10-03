ActiveAdmin.register User do

  permit_params :first_name, :last_name, :email, :password, :password_confirmation, role_ids: []

  index do
    id_column
    column :email
    column :roles
    actions
  end

  filter :email

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :grade
      row :speciality
      row :roles
    end
  end

  # controller do
  #   def create
  #     @user = User.new(:email, :password, :password_confirmation, :roles)
  #   end
  # end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end

    f.inputs "Add role" do
      f.input :roles,  :as => :select, :collection => Role.global
    end
    f.actions
  end
end







  # show do
  #   attributes_table do
  #     row :id
  #     row :email
  #     row :created_at
  #     row :updated_at
  #   end
  # end

  # controller do

  # @user = User.new(email: :email)
  
  #   if @user.save
  #     redirect_to '/admin/users'
  #   else
  #     render :new
  #   end                 
  # end


  
# end
