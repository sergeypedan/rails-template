# frozen_string_literal: true

desc "Checks bundle gems known vulnerabilities"

namespace :check do
  task bundle: :environment do
    Rake.application.invoke_task "bundle:audit"
  end
end
