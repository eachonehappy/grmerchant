class AddNewColumnToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :is_delivered, :boolean , default: nil
  end
end
