class AddColumnToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :amount, :integer
  	add_column :orders, :mode_of_payment, :string
  end
end
