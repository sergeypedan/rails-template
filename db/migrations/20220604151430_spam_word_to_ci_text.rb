class SpamWordToCiText < ActiveRecord::Migration[6.1]
	def up
		ActiveRecord::Base.connection.execute("CREATE EXTENSION IF NOT EXISTS citext;")

		ActiveRecord::Base.connection.execute(<<~SQL)
			ALTER TABLE spam_words
			ALTER COLUMN word
			SET DATA TYPE citext;
		SQL
	end

	def down
		ActiveRecord::Base.connection.execute(<<~SQL)
			ALTER TABLE spam_words
			ALTER COLUMN word
			SET DATA TYPE character varying;
		SQL
	end

end
