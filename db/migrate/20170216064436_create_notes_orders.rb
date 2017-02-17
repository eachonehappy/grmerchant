class CreateNotesOrders < ActiveRecord::Migration
  def change
    create_table :notes_orders do |t|
      t.string :description
      t.integer :order_id
      t.timestamps null: false
    end
  end
end
