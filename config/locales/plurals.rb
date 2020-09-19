# encoding: utf-8

# This file must be in config/locales/plurals.rb
# And do not forget initializers/pluralization.rb for back-end

{ ru:
  { i18n:
    { plural:
      { keys:  [:zero, :one, :few, :many],
        rule:  lambda { |n|
          if n == 0
            :zero
          elsif
            ( ( n % 10 ) == 1 ) && ( ( n % 100 != 11 ) )
            # 1, 21, 31, 41, 51, 61...
            :one
          elsif
            ( [2, 3, 4].include?(n % 10) \
            && ![12, 13, 14].include?(n % 100) )
            # 2-4, 22-24, 32-34...
            :few
          elsif ( (n % 10) == 0 || \
            ![5, 6, 7, 8, 9].include?(n % 10) || \
            ![11, 12, 13, 14].include?(n % 100) )
            # 0, 5-20, 25-30, 35-40...
            :many
          end
        }
      }
    }
  },
  # ru: { i18n: { plural: { keys: [:one, :few, :many, :other], rule: lambda { |n| n % 10 == 1 && n % 100 != 11 ? :one : [2, 3, 4].include?(n % 10) && ![12, 13, 14].include?(n % 100) ? :few : n % 10 == 0 || [5, 6, 7, 8, 9].include?(n % 10) || [11, 12, 13, 14].include?(n % 100) ? :many : :other } } } },
  en: { i18n: { plural: { keys: [:one, :other], rule: lambda { |n| n == 1 ? :one : :other } } } },
  es: { i18n: { plural: { keys: [:one, :other], rule: lambda { |n| n == 1 ? :one : :other } } } }
}
