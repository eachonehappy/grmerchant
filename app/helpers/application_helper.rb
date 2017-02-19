module ApplicationHelper
	def current_hour
		Time.current.to_s.split(" ")[1].split(":")[0]
	end

	def today_date
		(Time.now).strftime('%d%m%Y')
	end

	def tommorow_date
		(Time.now + 1.days).strftime('%d%m%Y')
	end

	def day_after_tommorow
		(Time.now + 2.days).strftime('%d%m%Y')
	end

	
 def last_merchant_pin

	User.where(:admin => false).maximum(:merchant_pin).to_i + 1
end

 def last_sku

	Recipe.maximum(:sku).to_i + 1
end
end
