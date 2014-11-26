module ApplicationHelper

	def header_sort_link(link_text, sort_param)
	 link_to(link_text, movies_path({sort: sort_param}), id: "#{sort_param}_header")
	end

	def th_class(hilite)
		return {class: 'hilite'} if hilite
		return {}
	end

  # takes array of ratings and value
  # returns true if value is in ratings
	def was_it_checked?(ratings, value)
		return false if ratings.nil?
		ratings.include? value
	end

end
