xml.instruct! :xml, version: "1.0"

xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do

	xml.url do
		xml.loc root_url
		xml.lastmod 3.days.ago.to_date
		xml.changefreq "weekly"
		xml.priority 1
	end

	xml.url do
		xml.loc about_url
		xml.lastmod 1.week.ago.to_date
		xml.changefreq "weekly"
		xml.priority 0.5
	end

	xml.url do
		xml.loc astrologers_url
		xml.lastmod 1.week.ago.to_date
		xml.changefreq "weekly"
		xml.priority 0.5
	end

	xml.url do
		xml.loc articles_url
		xml.lastmod 1.week.ago.to_date
		xml.changefreq "weekly"
		xml.priority 0.5
	end

	xml.url do
		xml.loc consultations_url
		xml.lastmod 1.week.ago.to_date
		xml.changefreq "weekly"
		xml.priority 0.5
	end

	xml.url do
		xml.loc concepts_url
		xml.lastmod 1.week.ago.to_date
		xml.changefreq "weekly"
		xml.priority 0.5
	end

	xml.url do
		xml.loc courses_url
		xml.lastmod 1.week.ago.to_date
		xml.changefreq "weekly"
		xml.priority 0.5
	end

	xml.url do
		xml.loc kootas_url
		xml.lastmod 1.week.ago.to_date
		xml.changefreq "weekly"
		xml.priority 0.5
	end

	# xml.url do
	# 	xml.loc nakshatras_url
	# 	xml.lastmod 1.week.ago.to_date
	# 	xml.changefreq "weekly"
	# 	xml.priority 0.5
	# end

	xml.url do
		xml.loc planets_url
		xml.lastmod 1.week.ago.to_date
		xml.changefreq "weekly"
		xml.priority 0.5
	end

	xml.url do
		xml.loc products_url
		xml.lastmod 1.week.ago.to_date
		xml.changefreq "weekly"
		xml.priority 0.5
	end

	# xml.url do
	# 	xml.loc tithis_url
	# 	xml.lastmod 1.week.ago.to_date
	# 	xml.changefreq "weekly"
	# 	xml.priority 0.5
	# end

	xml.url do
		xml.loc zodiac_signs_url
		xml.lastmod 1.week.ago.to_date
		xml.changefreq "weekly"
		xml.priority 0.5
	end


	@articles.each do |article|
		xml.url do
			xml.loc article_url(article.slug)
			xml.lastmod article.updated_at.to_date
			xml.changefreq "monthly"
			xml.priority 0.5
		end
	end

	@astrologers.each do |astrologer|
		xml.url do
			xml.loc astrologer_url(astrologer.slug)
			xml.lastmod astrologer.updated_at.to_date
			xml.changefreq "monthly"
			xml.priority 0.5
		end
	end

	@consultations.each do |consultation|
		xml.url do
			xml.loc consultation_url(consultation.slug)
			xml.lastmod consultation.updated_at.to_date
			xml.changefreq "monthly"
			xml.priority 0.5
		end
	end

	@concepts.each do |concept|
		xml.url do
			xml.loc concept_url(concept.slug)
			xml.lastmod concept.updated_at.to_date
			xml.changefreq "weekly"
			xml.priority 0.5
		end
	end

	@courses.each do |course|
		xml.url do
			xml.loc course_url(course.slug)
			xml.lastmod course.updated_at.to_date
			xml.changefreq "weekly"
			xml.priority 0.5
		end
	end

	@kootas.each do |koota|
		xml.url do
			xml.loc koota_url(koota.slug)
			xml.lastmod koota.updated_at.to_date
			xml.changefreq "weekly"
			xml.priority 0.5
		end
	end

	@planets.each do |planet|
		xml.url do
			xml.loc planet_url(planet.slug)
			xml.lastmod planet.updated_at.to_date
			xml.changefreq "weekly"
			xml.priority 0.5
		end
	end

	@products.each do |product|
		xml.url do
			xml.loc product_slug_url(product)
			xml.lastmod product.updated_at.to_date
			xml.changefreq "weekly"
			xml.priority 1
		end
	end

	# @questions.each do |question|
	# 	xml.url do
	# 		xml.loc question_url(question)
	# 		xml.lastmod question.updated_at.to_date
	# 		xml.changefreq "weekly"
	# 		xml.priority 1
	# 	end
	# end

	@zodiac_signs.each do |zodiac_sign|
		xml.url do
			xml.loc zodiac_sign_url(zodiac_sign.slug)
			xml.lastmod zodiac_sign.updated_at.to_date
			xml.changefreq "weekly"
			xml.priority 1
		end
	end

end
