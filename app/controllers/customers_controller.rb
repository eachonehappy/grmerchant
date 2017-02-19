class CustomersController < ApplicationController
	before_action :authenticate_user!
	before_action :shop_opened , only: [:new]
	def new
		@customer = Customer.new
	end
end
