require "active_record/connection_adapters/postgresql_adapter"

module ActiveRecord
	module ConnectionAdapters

		# NATIVE_DATABASE_TYPES
		# https://github.com/rails/rails/blob/main/activerecord/lib/active_record/connection_adapters/postgresql_adapter.rb#L123
		class PostgreSQLAdapter
			NATIVE_DATABASE_TYPES.merge!(
				citext:    { name: "citext" },
				datetime:  { name: "timestamptz" },
				# enum:      { name: "enum" },
				# primary_key: "bigserial primary key",
				# string:    { name: "text" },
				timestamp: { name: "timestamptz" }
			)
		end

	end
end
