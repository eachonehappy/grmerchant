class Order < ActiveRecord::Base
  has_many :recipes, through: :order_recipes
  has_many :order_recipes
  belongs_to :customer
  belongs_to :customer_address
  belongs_to :user
  has_many :notes_orders
  validates :amount, presence: true
  validates :o_id, presence: true, uniqueness: true
	
	end
