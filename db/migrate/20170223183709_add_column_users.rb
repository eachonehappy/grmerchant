class AddColumnUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :admin, :boolean, default: false
  	add_column :users, :role, :string, default: "merchant"
  end
end
