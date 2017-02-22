module ApplicationHelper
	def page_title(title)
		app_title = "Where-For-Lunch"
		if title.empty?
			app_title
		else
			"#{title} | #{app_title}"
		end
	end
end
