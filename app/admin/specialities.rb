ActiveAdmin.register Speciality do

  permit_params :id, :name

  index do
    id_column
    column :name
    column :created_at
    column :updated_at
    actions
  end

  filter :name

  show do
    attributes_table do
      row :name
    end
  end

  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end

end
