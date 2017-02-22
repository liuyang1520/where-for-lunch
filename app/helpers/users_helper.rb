module UsersHelper
	def user_icon_image(user, size = 40)
		user_email = Digest::MD5::hexdigest(user.email.downcase)
		user_icon_url = "https://secure.gravatar.com/avatar/#{user_email}"
		image_tag(user_icon_url, alt: user.name, class: "user_icon_image", size: size)
	end
end
