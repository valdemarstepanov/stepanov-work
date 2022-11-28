class AddForeignKey < ActiveRecord::Migration[7.0]
  def change

    add_reference :pools, :pool_container, foreign_key: {on_delete: :cascade}
    add_reference :pool_containers, :user, foreign_key: {on_delete: :cascade}
  end
end
