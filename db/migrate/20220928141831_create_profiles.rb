class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name

      t.timestamps
    end

    add_column :grades, :profile_id, :bigint
    add_column :specialities, :profile_id, :bigint

    add_index :grades, :profile_id
    add_index :specialities, :profile_id

  end
end
