ActiveAdmin.register Grade do

  permit_params :id, :name, :level

  index do
    id_column
    column(:Name) { |grade| grade.name }
    column(:Level) { |grade| grade.level }
    column :created_at
    column :updated_at
    actions
  end

  filter :name
  filter :level

  show do
    attributes_table do
      row :name
      row :level
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :level
    end
    f.actions
  end
end
