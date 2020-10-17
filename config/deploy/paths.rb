# frozen_string_literal: true

$domain               = ""
$repo_url             = "git@"
$deploy_user          = ""

$project_dir          = "/var/www/#{$domain}"
$git_dir              = "#{$project_dir}/git"
$work_dir             = "#{$project_dir}/current"
$shared_dir           = "#{$project_dir}/shared"
$backups_dir          = "#{$project_dir}/backups"

$ruby_version         = "2.7.1" # requires re-uploading Puma systemd service
$ruby_version_minor   = "#{$ruby_version[0..2]}.0"
$ruby_dir             = "/opt/rubies/ruby-#{$ruby_version}"
$ruby_bin_dir         = "#{$ruby_dir}/bin" # /opt/rubies/ruby-2.7.1/bin
$gem_dir_ruby         = "#{$ruby_dir}/lib/ruby/gems/#{$ruby_version_minor}" # gems reside inside `/gems` dir

$bundle_dir           = "#{$shared_dir}/bundle"
$gem_dir_bundle       = "#{$bundle_dir}/ruby/#{$ruby_version_minor}" # gems reside inside `/gems` dir
$bundle_bin_dir       = "#{$gem_dir_bundle}/bin"

$gem_dirs             = [$gem_dir_bundle, $gem_dir_ruby]
$gemfile_path         = "#{$work_dir}/Gemfile"
$current_bin_dir      = "#{$work_dir}/bin"

$chruby_script_path   = "/usr/local/chruby/share/chruby/chruby.sh"
$chruby_exec_path     = "/usr/local/bin/chruby-exec"

$node_version         = "14.13.0"
$node_bin_dir         = "/#{$deploy_user}/.nvm/versions/node/v#{$node_version}/bin"
$nvm_script           = "/#{$deploy_user}/.nvm/nvm.sh"
$yarn_bin_dir         = "/usr/bin"

$bin_dirs             = [ $current_bin_dir,
                          $bundle_bin_dir,
                          $ruby_bin_dir,
                          $node_bin_dir,
                          $yarn_bin_dir,
                          "/usr/local/bin",
                          "/bin" ]

$rails_env            = "production"
$db_config            = "#{$work_dir}/config/database.yml"

$puma_binstub_path    = "#{$current_bin_dir}/puma"
$puma_config_path     = "#{$shared_dir}/config/puma.rb"
$puma_control_app     = false
$puma_daemonize       = false # because systemd needs a foreground process https://github.com/puma/puma/blob/master/docs/systemd.md
$puma_exe_path        = "#{$bundle_bin_dir}/puma"
$puma_init_AR         = true
$puma_log_dir         = "/var/log/puma"
$puma_log_path_access = "#{$puma_log_dir}/#{$domain}.stdout.log"
$puma_log_path_error  = "#{$puma_log_dir}/#{$domain}.stderr.log"
$puma_pid_dir         = "/var/run"
$puma_pid_path        = "#{$puma_pid_dir}/puma-#{$domain}.pid"
$puma_port            = 3000
$puma_preload_app     = true
$puma_rackup_path     = "#{$work_dir}/config.ru"
$puma_socket_dir      = $puma_pid_dir
$puma_socket_path     = "#{$puma_socket_dir}/puma-#{$domain}.sock" # "/var/run/puma-sergeypedan.ru.sock"
$puma_state_path      = "#{$puma_pid_dir}/puma-#{$domain}.state"
$puma_systemd_bins    = [$ruby_bin_dir, $node_bin_dir]
$puma_systemd_service = "puma_#{$domain}.service"
$puma_threads_max     = 8
$puma_threads_min     = 1
$puma_workers         = 0
$pumactl_binstub_path = "#{$current_bin_dir}/pumactl"
$pumactl_exe_path     = "#{$bundle_bin_dir}/pumactl"

puma_cmd_start       = [
  "#{$puma_binstub_path} --config #{$puma_config_path} #{$puma_rackup_path}",
  "#{$puma_binstub_path} --config #{$puma_config_path} start",
  "#{$chruby_exec_path} #{$ruby_version} -- bundle exec puma --config #{$puma_config_path} start",
  "/bin/bash -i -l -c chruby #{$ruby_version} && bundle exec pumactl --config-file #{$puma_config_path} start",
  "#{$puma_exe_path} --config #{$puma_config_path} start"
]

puma_cmd_restart     = [
  "#{$pumactl_binstub_path} --config-file #{$puma_config_path} restart",
  "#{$chruby_exec_path} #{$ruby_version} -- bundle exec pumactl --config-file #{$puma_config_path} restart",
  "#{$pumactl_exe_path} --config-file #{$puma_config_path} restart"
]

puma_cmd_stop        = [
  "#{$pumactl_binstub_path} --config-file #{$puma_config_path} stop",
  "#{$chruby_exec_path} #{$ruby_version} -- bundle exec pumactl --config-file #{$puma_config_path} stop",
  "#{$pumactl_exe_path} --config-file #{$puma_config_path} stop",
  "/bin/kill -TERM $MAINPID"
]

$puma_command_start   = puma_cmd_start[0]
$puma_command_restart = puma_cmd_restart[0]
$puma_command_stop    = puma_cmd_stop[3]

# Variant: Use `bundle exec --keep-file-descriptors puma` instead of binstub

$sidekiq_config       = "#{$work_dir}/config/sidekiq.yml"
$sidekiq_logfile      = "/var/log/sidekiq-#{$domain}.log"
$sidekiq_pidfile      = "/var/run/sidekiq-#{$domain}.pid"
