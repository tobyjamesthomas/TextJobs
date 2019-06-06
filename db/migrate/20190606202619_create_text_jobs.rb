class CreateTextJobs < ActiveRecord::Migration
  def change
    create_table :text_jobs do |t|
      t.references :job, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
