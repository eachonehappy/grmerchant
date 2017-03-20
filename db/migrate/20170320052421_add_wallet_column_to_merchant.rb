class AddWalletColumnToMerchant < ActiveRecord::Migration
  def change
  	add_column :users, :wallet, :float, default: 0
  end
end
