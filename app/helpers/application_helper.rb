module ApplicationHelper
	def current_hour
		"#{Time.now}".split(" ")[1].split(":")[0]
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


end
