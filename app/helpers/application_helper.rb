module ApplicationHelper
	def shorten_string(data)
		truncate(data, length: 40, omission: '....')
	end

	def shorten_string_high(data)
		truncate(data, length: 30, omission: '....')
	end
end
