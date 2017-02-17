class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :authentication_keys => [:merchant_pin]


 # validates :email, :presence => true, :email => true
 has_many :customers, through: :customer_users
 has_many :customer_users
 has_many :recipes, through: :cart_recipes
 has_many :cart_recipes
 has_many :orders
 validates :merchant_pin, presence: true, uniqueness: true
 validates :full_name, presence: true
 validates :address, presence: true
 validates :phone, presence: true, uniqueness: true, length: { minimum: 10, maximum: 10 }
end
