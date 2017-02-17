class AddIdColumnToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :o_id, :string
  end
end
