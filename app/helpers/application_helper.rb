module ApplicationHelper

	def header_sort_link(link_text, sort_param)
	 link_to(link_text, movies_path({sort: sort_param}), id: "#{sort_param}_header")
	end

	def th_class(hilite)
		return {class: 'hilite'} if hilite
		return {}
	end

	def was_it_checked?(value)
		value == "true"
	end

end
