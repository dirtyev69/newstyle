lock '3.5.0'
require 'bundler/capistrano'
require 'capistrano_colors'

load '/config/deploy/tasks/tasks.rb'


set :keep_releases, 3

set :default_stage, 'production'
set :stages, %w(production)

set :application, "prod"

set :git_application_name       , 'prod'
set :deploy_to_application_name , application


set :symlinks,  [
                  { :label => :db, :path => 'config/database.yml' },
                ]

# require 'whenever/capistrano'
# set :whenever_command, 'bundle exec whenever'

default_run_options[:pty] = true

set :group_writable, false
set :scm_verbose, true

set :scm, :git
set :deploy_via, :remote_cache
set :copy_exclude, [".git"]

set :shared_children, shared_children + %w(tmp/sockets public/uploads)

# Bundle config
set :bundle_binary, "bundle"
set :bundle_flags,  "--deployment"

set :ssh_options, {
  forward_agent: true,
  paranoid: true,
  keys: "~/.ssh/id_rsa_prod"
}


namespace :assets do
  task :precompile, :roles => :web do
    from = source.next_revision(current_revision)
    if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ lib/assets/ app/assets/ | wc -l").to_i > 0
      run_locally("RAILS_ENV=#{rails_env} rake assets:clean && RAILS_ENV=#{rails_env} rake assets:precompile")
      run_locally "cd public && tar -jcf assets.tar.bz2 assets"
      top.upload "public/assets.tar.bz2", "#{shared_path}", :via => :scp
      run "cd #{shared_path} && tar -jxf assets.tar.bz2 && rm assets.tar.bz2"
      run_locally "rm public/assets.tar.bz2"
      run_locally("rake assets:clean")
    else
      logger.info "Skipping asset precompilation because there were no asset changes"
    end
  end

  task :symlink, roles: :web do
    run ("rm -rf #{latest_release}/public/assets &&
          mkdir -p #{latest_release}/public &&
          mkdir -p #{shared_path}/assets &&
          ln -s #{shared_path}/assets #{latest_release}/public/assets")
  end
end

set :unicorn_binary, "unicorn"

after 'deploy:restart', 'deploy:cleanup'


# config valid only for current version of Capistrano

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# namespace :deploy do

#   after :restart, :clear_cache do
#     on roles(:web), in: :groups, limit: 3, wait: 10 do
#       # Here we can do anything such as:
#       # within release_path do
#       #   execute :rake, 'cache:clear'
#       # end
#     end
#   end

# end
