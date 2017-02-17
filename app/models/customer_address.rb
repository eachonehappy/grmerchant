class CustomerAddress < ActiveRecord::Base
	belongs_to :customer
	has_many :orders
	validates :address, presence: true

end
