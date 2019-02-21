class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :phone
      t.string :first_name
      t.boolean :store
      t.boolean :coffee
      t.boolean :call_center

      t.timestamps null: false
    end
  end
end
