class Recipe < ActiveRecord::Base
  has_many :users, through: :cart_recipes
  has_many :cart_recipes
  has_many :orders, through: :order_recipes
  has_many :order_recipes
  validates :sku, presence: true, uniqueness: true
	validates :name, presence: true
	validates :price, presence: true
	validates :serving, presence: true

end
