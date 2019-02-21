class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :employer
      t.string :title
      t.string :description
      t.string :location
      t.float :wage
      t.datetime :expiry
      t.string :link

      t.timestamps null: false
    end
  end
end
