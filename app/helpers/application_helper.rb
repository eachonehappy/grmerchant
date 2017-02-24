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

	(User.all.count.to_i + 1).to_s.rjust(3, '0')
end

 def last_sku

	Recipe.maximum(:sku).to_i + 1
end
def admin
    current_user.role == "admin"
  end

  def manager
    current_user.role == "manager"
  end

  def operator
    current_user.role == "operator"
  end

  def data_entry
    current_user.role == "data_entry"
  end

  def merchant
    current_user.role == "merchant"
  end

  def marketing
    current_user.role == "marketing"
  end
end
