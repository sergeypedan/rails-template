ActiveAdmin.register DrugIntake do

	menu parent: "Medicine"

	permit_params :drug_id, :dosage

	config.filters = false
	config.sort_order = :position_asc

	filter :email
	filter :experience, as: :select, collection: %w(Новичок Любитель Гуру)
	filter :location, collection: -> { Location.all.map { |l| ["#{l.name} (#{l.city.name})", l.id] } }

	includes :drug
	includes location: [:city]
	includes :question, :user, { question: :station }
	includes [{ drug: :form }]

	index do
		selectable_column
		id_column

		column :name

		column :color do |record|
			div nil, style: "background-color: #{record.color}; width: 1.5em; height: 1.5em; border-radius: 50%;"
		end

		column(:access_area) { |course| Course::ACCESS_AREAS[course.access_area] }
		column("On sale")  { |course| course.sellable.on_sale }
		column "Лекций", :lectures_count

		column :url do |record|
			link_to record.url.sub("https://", ""), record.url, rel: "noreferrer nofollower", target: "_blank"
		end
		toggle_bool_column :published

		number_column :amount_value, as: :currency

		actions
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
				f.input :list_image, as: :file, hint: active_storage_file_input_hint(f, :list_image)
				f.input :logo, as: :file, hint: (image_tag(f.object.logo.url(:admin)) if f.object.persisted? && f.object.logo.url)
			end
		end

		f.semantic_errors
		f.actions
	end


	after_save do
		if resource.valid?
			resource.create_sellable!    unless resource.sellable
			resource.create_seo_content! unless resource.seo_content
		end
	end

end
