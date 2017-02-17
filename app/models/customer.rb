class Customer < ActiveRecord::Base
   has_many :users, through: :customer_users
   has_many :customer_users
   has_many :orders
   has_many :customer_addresses
   validates :name, presence: true
	 validates :phone, presence: true, uniqueness: true,:numericality => true, length: { minimum: 10, maximum: 10 }

end
