class CustomersController < ApplicationController
	before_action :authenticate_user!
	def new
		@customer = Customer.new
	end
end
