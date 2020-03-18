# frozen_string_literal: true

desc "Runs all tests"

namespace :check do
  task :all do
    puts "Running 'rake check:routes'\n"
    Rake.application.invoke_task "check:routes"

    puts "\n------------------------\n"

    puts "Running 'rake check:db:unused'\n"
    Rake.application.invoke_task "check:db:unused"

    puts "\n------------------------\n"

    puts "Running 'rake check:db:consistency'\n"
    Rake.application.invoke_task "check:db:consistency"

    puts "\n------------------------\n"

    puts "Running 'rake check:bundle'\n"
    Rake.application.invoke_task "check:bundle"

    puts "\n------------------------\n"

    puts "Running 'rake check:translations'\n"
    Rake.application.invoke_task "check:translations"
  end
end
