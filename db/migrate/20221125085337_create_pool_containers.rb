class CreatePoolContainers < ActiveRecord::Migration[7.0]
  def change
    create_table :pool_containers do |t|
            
      t.timestamps
    end
  end

end
