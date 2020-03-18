# frozen_string_literal: true

desc "Checks missing translations with help of “localer” gem"

namespace :check do
  task translations: :environment do
    Rake.application.invoke_task "localer"
  end
end
