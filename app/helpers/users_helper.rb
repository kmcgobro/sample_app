module UsersHelper
	def avatar_for(user)
		image_tag("def_user.jpg",
					:alt => user.name,
					:class => "avatar")
	end
end
