require 'date'

module AssignmentsHelper
	def calculate_days(start_date, end_date)
			(end_date - start_date).to_f / 86400
	end

	def days_left(end_date)
		d = Time.now
		(end_date - d).to_f / 86400
	end

	def percentage(start_date,end_date)
		left_days = days_left(end_date)
		total_days = calculate_days(start_date,end_date)
		percentage = (total_days - left_days).to_f / total_days
		# percentage = 10.to_f / total_days
		return percentage
		
	end
end
