class AddMessageFieldsToTextJob < ActiveRecord::Migration
  def change
    add_column :text_jobs, :to, :string
    add_column :text_jobs, :from, :string
    add_column :text_jobs, :body, :string
    add_column :text_jobs, :url, :string
    add_column :text_jobs, :clicked, :boolean, :default => false
  end
end
