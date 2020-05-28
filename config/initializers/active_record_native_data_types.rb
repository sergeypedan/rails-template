require "active_record/connection_adapters/postgresql_adapter"

module ActiveRecord
  module ConnectionAdapters
    class PostgreSQLAdapter
      NATIVE_DATABASE_TYPES.merge!(
        datetime:  { name: "timestamptz" },
        # enum:      { name: "enum" },
        # primary_key: "bigserial primary key",
        # string:    { name: "text" }
        timestamp: { name: "timestamptz" }
      )
    end
  end
end
