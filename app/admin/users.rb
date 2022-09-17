ActiveAdmin.register DrugIntake do

	menu parent: "Medicine"

	permit_params :dosage,
								:drug_id,
								child_conception_ids: [],
								parent_conception_ids: [],
								related_conception_ids: [],
								web_links_attributes: [:id, :url, :text, :position, :_create, :_destroy, :_update]
	permit_params DrugIntake.column_names.map(&:to_sym)

	config.sort_order = "position_asc"

	include ActiveAdmin::SortableTable # creates the controller action which handles the sorting

	filter :email
	filter :experience, as: :select, collection: %w(Новичок Любитель Гуру)
	filter :location, collection: -> { Location.all.map { |l| ["#{l.name} (#{l.city.name})", l.id] } }

	config.filters = false
	remove_filter :conception_associations

	includes :drug
	includes location: [:city]
	includes :question, :user, { question: :station }
	includes [{ drug: :form }]

	scope("Все") { |scope| scope }
	scope("Не написанные") { |scope| scope.where(description: [nil, ""]) }

	index do
		handle_column
		selectable_column
		id_column

		column :created_at do |record| l(record.created_at, format: "%-d %B %Y") end
		column :name

		column :color do |record|
			div nil, style: "background-color: #{record.color}; width: 1.5em; height: 1.5em; border-radius: 50%;"
		end

		column(:access_area) { |course| Course::ACCESS_AREAS[course.access_area] }
		column("On sale")  { |course| course.sellable.on_sale }
		column "Лекций", :lectures_count
		column :text do |record| record.text.truncate(30) end

		column :url do |record|
			link_to record.url.sub("https://", ""), record.url, rel: "noreferrer nofollower", target: "_blank"
		end

		toggle_bool_column :published

		number_column :amount_value, as: :currency

		actions
	end


	after_save do
		if resource.valid?
			resource.create_sellable!    unless resource.sellable
			resource.create_seo_content! unless resource.seo_content
		end
	end


	after_create do
		if resource.valid?
			resource.create_sellable!    unless resource.sellable
			resource.create_seo_content! unless resource.seo_content
		end
	end


	form do |f|
		f.inputs do
			f.input :page, as: :select, collection: ContentBlock::PAGES.map { |slug, name| [name, slug] }.to_h
			f.input :drug, as: :select, collection: Drug.pluck(:name, :id)
			f.input :dosage
			f.input :created_at, as: :date_time_picker
			f.input :datetime, as: :date_time_picker

			f.has_many :sellable, allow_destroy: false, new_record: false do |s|
				s.input :return_policy
			end
		end

		tab "Фото" do
			f.inputs do
				f.input :cover_image_bg_color
			end

			f.inputs do
				attr = :logo
				attachment = f.object.public_send(attr)
				f.input attr, as: :hidden, input_html: { value: f.object.public_send("cached_#{attr}_data") }
				f.input attr, as: :file,   hint: (image_tag(attachment.url, height: 80) if attachment)
			end

			f.inputs do
				attr = :list_image
				attachment = f.object.public_send(attr, :admin)
				hint = (image_tag(attachment.url) if (f.object.public_send(attr) && attachment))
				f.input attr, as: :hidden, input_html: { value: f.object.public_send("cached_#{attr}_data") }
				f.input attr, as: :file, hint: hint
			end

			f.inputs do
				f.input :list_image, as: :file, hint: active_storage_file_input_hint(f, :list_image)
				f.input :logo, as: :file, hint: (image_tag(f.object.logo.url(:admin)) if f.object.persisted? && f.object.logo.url)
			end
		end

		f.semantic_errors
		f.actions
	end


	show do
		attributes_table(*default_attribute_table_rows)

		attributes_table do
			row(:photo) do
				image_tag user.photo(:standard) if user.photo
			end
			row :id
			row :uid
			row :first_name
			row :last_name
		end

		panel "Child conceptions" do
			table_for(resource.child_conceptions) do
				column :name
				column :name_en
			end
		end
	end

end
