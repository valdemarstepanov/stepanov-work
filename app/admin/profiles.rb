ActiveAdmin.register Profile do
  permit_params :first_name, :last_name, :grade_id, :speciality_id, :user_id,
  user_attributes: [:id, :email, :password, :password_confirmation, role_ids: []],
  grade_attributes: [:id, :name, :level],
  speciality_attributes: [:id, :name]

  index do
    id_column
    column :first_name
    column :last_name
    column(:Grade_name) { |profile| profile.grade.name }
    column(:Grade_level) { |profile| profile.grade.level }
    column :speciality
    column :user
    column(:Role_name) { |profile| profile.user.roles }
  end


  controller do
    def create

      result = ::ProfileCreator.new.call(params)

      if result.present?
        redirect_to admin_root_path, notice: t('admin.users.controller.create.flash.notice')
      else
        redirect_to new_admin_profile_path, alert: t('admin.users.controller.create.flash.alert')
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.attribute_names
    f.inputs 'Profile' do
      f.input :first_name
      f.input :last_name
      f.input :grade
      f.input :speciality
    end
    
      f.inputs 'User', for: [:user, User.new] do |p|
        p.input :email
        p.input :roles
        p.input :password
        p.input :password_confirmation
      end

      f.inputs 'Speciality', for: [:speciality, f.object.speciality || Speciality.new] do |p|
        p.input :name
      end
    
    f.inputs 'Grade', for: [:grade, f.object.grade || Grade.new] do |p|
      p.input :name
      p.input :level
    end
    
    f.actions
  end

  action_item :only => :index do
    link_to 'Upload CSV', :action => 'upload_csv'
  end

  collection_action :upload_csv do
    render "admin/csv/upload_csv"
  end

  collection_action :import_csv, method: :post do
    
    if params[:dump].present?
    
      import = CsvImportUsersService.new
      import.convert_save(params[:dump][:file])
      redirect_to({ action: :index })
      
      if import.message.notice.present?
        flash[:notice] = import.message.notice
      end

      if import.message.error.present?
        flash[:error] = import.message.error
      end
      
    else
      redirect_to({ action: :upload_csv })
      flash[:error] = 'File is not exists!'
    end
  end

  controller do
    def scoped_collection
      super.includes [user: :roles], :grade, :speciality
    end
  end
end
