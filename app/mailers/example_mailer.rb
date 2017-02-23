class ExampleMailer < ApplicationMailer
	default from: "adityasingh7072@gmail"

	def sample_email  
	    mail(to: 'work.asingh@gmail.com', subject: 'Sample Email')
	  end
end
