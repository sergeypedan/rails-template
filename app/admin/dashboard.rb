# frozen_string_literal: true

ActiveAdmin.register_page "Dashboard" do
	menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

	content title: proc { I18n.t("active_admin.dashboard") } do

		# div class: "blank_slate_container", id: "dashboard_default_message" do
		# 	span class: "blank_slate" do
		# 		span I18n.t("active_admin.dashboard_welcome.welcome")
		# 		small I18n.t("active_admin.dashboard_welcome.call_to_action")
		# 	end
		# end

		# Here is an example of a simple dashboard with columns and panels.
		#
		columns do
			column do

				panel "Recent registrations" do
					table_for(User.order(created_at: :desc).limit(30)) do |table|
						column :created_at do |record|
							link_to(l(record.created_at, format: "%Y %B %-d"), admin_user_path(record), style: "white-space: nowrap")
						end
						column :full_name
						column :email
					end
				end
			end

			column do
				panel "Recent feedbacks" do
					table_for(Feedback::DealBreaker.order(created_at: :desc).limit(30)) do |feedback|
						column :created_at do |record|
							link_to(l(record.created_at, format: "%-d %b %Y"), admin_feedback_deal_breaker_path(record), style: "white-space: nowrap")
						end
						column :content
					end
				end
			end
		end

	end
end
