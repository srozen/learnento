# config valid only for current version of Capistrano
lock '3.4.0'

set :application, "learnento"
set :repo_url,  "git@github.com:srozen/learnento.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, false

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', )

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5


# if you want to remove the dump file after loading
set :db_local_clean, true
# if you want to remove the dump file from the server after downloading
set :db_remote_clean, true
# if you are highly paranoid and want to prevent any push operation to the server
set :disallow_pushing, false

# If you want to import assets, you can change default asset dir (default = system)
# This directory must be in your shared directory on the server


# config/deploy.rb
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.3.0'

# in case you want to set ruby version from the file:
# set :rbenv_ruby, File.read('.ruby-version').strip

set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
# set :rbenv_map_bins, %w{rake gem bundle ruby rails puma}
set :rbenv_roles, :all # default value

# set :puma_rackup, -> { File.join(current_path, 'config.ru') }
# set :puma_state, "#{shared_path}/tmp/pids/puma.state"
# set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
# set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"    #accept array for multi-bind
# set :puma_conf, "#{shared_path}/puma.rb"
# set :puma_access_log, "#{shared_path}/log/puma_access.log"
# set :puma_error_log, "#{shared_path}/log/puma_error.log"
# set :puma_role, :app
# set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
# set :puma_threads, [0, 16]
# set :puma_workers, 0
# set :puma_worker_timeout, nil
# set :puma_init_active_record, false
set :puma_init_active_record, true
# set :puma_preload_app, true
set :puma_preload_app, true

# use local template instead of included one with capistrano-maintenance
set :maintenance_template_path, 'app/views/maintenance.html.erb'
set :maintenance_config_warning, false


namespace :deploy do

  desc "Setup maintenance reason and deadline"
  task :setup_maintenance_for_deploy do

    ENV['REASON'] ||= "Deployment of new version"
    ENV['UNTIL'] ||= 10.minutes.from_now.to_datetime.to_formatted_s(:rfc822)
  end

  desc 'Runs rake db:seed'
  task :seed => [:set_rails_env] do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:seed"
        end
      end
    end
  end
  desc 'Runs rake db:reset'
  task :reset => [:set_rails_env] do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:reset"
        end
      end
    end
  end


end




before "deploy:starting", "deploy:setup_maintenance_for_deploy"
before "deploy:starting", "maintenance:enable"
# after 'deploy:migrate', 'deploy:seed'
after 'deploy:publishing', 'deploy:restart'
after "deploy:finished", "maintenance:disable"


Airbrussh.configure do |config|
  # Capistrano's default, un-airbrusshed output is saved to a file to
  # facilitate debugging.
  #
  # To disable this entirely:
  # config.log_file = nil
  #
  # Default:
  # config.log_file = "log/capistrano.log"

  # Airbrussh patches Rake so it can access the name of the currently executing
  # task. Set this to false if monkey patching is causing issues.
  #
  # Default:
  # config.monkey_patch_rake = true

  # Ansi colors will be used in the output automatically based on whether the
  # output is a TTY, or if the SSHKIT_COLOR environment variable is set.
  #
  # To disable color always:
  # config.color = false
  #
  # Default:
  # config.color = :auto

  # Output is automatically truncated to the width of the terminal window, if
  # possible. If the width of the terminal can't be determined, no truncation
  # is performed.
  #
  # To truncate to a fixed width:
  # config.truncate = 80
  #
  # Or to disable truncation entirely:
  # config.truncate = false
  #
  # Default:
  # config.truncate = :auto

  # If a log_file is configured, airbrussh will output a message at startup
  # displaying the log_file location.
  #
  # To always disable this message:
  # config.banner = false
  #
  # To display an alternative message:
  # config.banner = "Hello, world!"
  #
  # Default:
  # config.banner = :auto

  # You can control whether airbrussh shows the output of SSH commands. For
  # brevity, the output is hidden by default.
  #
  # Display stdout of SSH commands. Stderr is not displayed.
  # config.command_output = :stdout
  #
  # Display stderr of SSH commands. Stdout is not displayed.
  # config.command_output = :stderr
  #
  # Display all SSH command output.
  # config.command_output = [:stdout, :stderr]
  # or
  # config.command_output = true
  #
  # Default (all output suppressed):
  # config.command_output = false
end





