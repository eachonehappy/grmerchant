class CreateSmsMessages < ActiveRecord::Migration
  def change
    create_table :sms_messages do |t|
      t.string :sms_message
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
