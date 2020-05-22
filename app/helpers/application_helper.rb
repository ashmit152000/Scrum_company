module ApplicationHelper
	def shorten_string(data)
		truncate(data, length: 40, omission: '....')
	end
end
