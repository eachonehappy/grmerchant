class AddColumnToUser < ActiveRecord::Migration
  def change
  	remove_column :users, :phone, :integer
  	add_column :users, :phone, :text

  end
end
