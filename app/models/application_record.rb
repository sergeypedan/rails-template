# frozen_string_literal: true
puts "            [App] `models/application_record.rb`"
class ApplicationRecord < ActiveRecord::Base

	self.abstract_class = true

	# User.where_any_of({ role: "owner" }, { id: 1 })
	# User.where_any_of(User.where(role: "owner"), User.where(id: 1))
	#
	# SELECT "users".* FROM "users" WHERE ("users"."role" = $1 OR "users"."id" = $2)
	# => [#<User id: 1, role: "owner">]
	#
	def self.where_any_of(*conditions)
		where(
			conditions
				.map { |condition|
					case condition
					when Array                  then where(*condition)
					when Hash, String           then where(condition)
					when ActiveRecord::Relation then condition
					end
				}
				.map { |query| query.arel.constraints.reduce(:and) }
				.reduce(:or)
		)
	end

end
