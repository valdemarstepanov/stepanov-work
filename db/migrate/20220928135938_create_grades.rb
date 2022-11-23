class CreateGrades < ActiveRecord::Migration[7.0]
  def change
    create_table :grades do |t|
      t.string :name, null: false
      t.string :level, null: false
      
      t.timestamps
    end
   
    add_index :grades, :name

  end
end
