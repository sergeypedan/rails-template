# frozen_string_literal: true

class Video < ApplicationRecord

	# Validations

	validates :duration,     presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
	validates :lecture_id,   presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
	validates :position,     presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
	validates :poster,       content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 5.megabytes }
	validates :provider,     presence: true, inclusion: { in: Integral::Video::Provider.names }
	validates :provider_uid, presence: true
	validates :title,        presence: true


	# Attachments

	has_one_attached :poster


	# Associations
	belongs_to :lecture, counter_cache: true, touch: :duration
	has_one    :teacher, inverse_of: :intro_video


	# Methods

	def provider_poster
		Integral::Video::Provider.new(provider).poster_url(provider_uid)
	end

end

# == Schema Information
#
# Table name: videos
#
#  id           :bigint           not null, primary key
#  duration     :integer          default(0), not null
#  excerpt      :text
#  position     :integer          default(0), not null
#  provider     :string           default("YouTube"), not null
#  provider_uid :string           not null
#  title        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  lecture_id   :bigint           not null, indexed
#
# Indexes
#
#  index_videos_on_lecture_id  (lecture_id)
#
# Foreign Keys
#
#  fk_rails_...  (lecture_id => lectures.id)
#
