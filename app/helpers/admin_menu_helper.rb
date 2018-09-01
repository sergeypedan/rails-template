module AdminMenuHelper

	def admin_menu_current_page?(model)
		if request.env["action_dispatch.request.parameters"][:controller] == "admin/#{model}"
			"list-group-item active"
		else
			"list-group-item"
		end
	end


	def admin_add_btn(resource)
		"/admin/#{resource.pluralize}/new"
	end

end
