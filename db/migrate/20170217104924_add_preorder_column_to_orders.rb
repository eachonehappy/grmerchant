class AddPreorderColumnToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :preorder, :boolean, default: false
  end
end
