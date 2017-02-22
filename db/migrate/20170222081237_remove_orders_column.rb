class RemoveOrdersColumn < ActiveRecord::Migration
  def change
  	remove_column :orders, :message, :string
  end
end
