# encoding: utf-8

# This file must be in config/locales/plurals.rb
# And do not forget initializers/pluralization.rb for back-end

{
	en: {
		i18n: {
			plural: {
				keys: [:one, :other],
				rule: lambda { |n| n == 1 ? :one : :other }
			}
		}
	},

	ru: {
		i18n: {
			plural: {
				keys: [:zero, :one, :few, :many, :other],
				rule: lambda { |n|
					if n.is_a? Symbol
						if [:zero, :one, :few, :many, :other].include?(n) then n
						else fail ArgumentError, "Allowed keys are :zero, :one, :few, :many, :other, you pass #{n.inspect}"
						end
					elsif n.is_a? Numeric
						if n == 0 then :zero
						elsif
							(n % 10 == 1) && (n % 100 != 11)
							# 1, 21, 31, 41, 51, 61...
							:one
						elsif
							(      [2, 3, 4].include?(n % 10) \
							&& ![12, 13, 14].include?(n % 100) )
							# 2-4, 22-24, 32-34...
							:few
						elsif
							(n % 10 == 0) || \
							 [5, 6, 7, 8, 9].include?(n % 10) || \
							[11, 12, 13, 14].include?(n % 100)
							# 0, 5-20, 25-30, 35-40...
							:many
						else :other
						end
					else
						fail TypeError, "`count` must be a either an Numeric or a Symbol, you pass #{n.inspect}"
					end
				}
			}
		}
	}
}
