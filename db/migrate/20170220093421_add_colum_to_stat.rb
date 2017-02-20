class AddColumToStat < ActiveRecord::Migration
  def change
  	add_column :stats, :sms_accept, :boolean , default: false
  end
end
