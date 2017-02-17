class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.boolean :shop_open , default: false 
      t.timestamps null: false
    end
  end
end
