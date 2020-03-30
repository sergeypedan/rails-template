# frozen_string_literal: true

namespace :deploy do

  desc "Restarts Puma with systemd"

  task :restart do
    execute :systemctl, :stop,  fetch(:puma_systemd_service)
    execute :systemctl, :start, fetch(:puma_systemd_service)
  end
end
