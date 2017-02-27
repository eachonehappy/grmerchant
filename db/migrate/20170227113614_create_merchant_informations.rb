class CreateMerchantInformations < ActiveRecord::Migration
  def change
    create_table :merchant_informations do |t|
	  t.string :full_name
      t.text   :address
      t.string  :phone
      t.boolean  :non_veg, default: true
      t.boolean  :is_accepted,default: false

      t.timestamps null: false
    end
  end
end
