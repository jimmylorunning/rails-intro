module ApplicationHelper
	def header_sort_link(link_text, sort_param)
	 link_to(link_text, movies_path({sort: sort_param}), id: "#{sort_param}_header")
	end
end
