# frozen_string_literal: true

namespace :deploy do

  desc "Copies master.key file if absent"

  task :set_master_key do
    on roles(:app), in: :sequence, wait: 10 do
      unless test("[ -f #{shared_path}/config/master.key ]")
        upload! "config/master.key", "#{shared_path}/config/master.key"
      end
    end
  end
end
