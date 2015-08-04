require 'rvm/capistrano'

require 'bundler/capistrano'

require 'capistrano_colors'
require 'capistrano/ext/multistage'

set :default_stage, 'production'
set :stages, %w(production)

set :application, "prod"

set :git_application_name       , 'prod'
set :deploy_to_application_name , application


set :symlinks,  [
                  { :label => :db, :path => 'config/database.yml' },
                ]

require 'whenever/capistrano'
set :whenever_command, 'bundle exec whenever'

default_run_options[:pty] = true

set :group_writable, false
set :scm_verbose, true

set :scm, :git
set :deploy_via, :remote_cache
set :copy_exclude, [".git"]
set :normalize_asset_timestamps, false

set :shared_children, shared_children + %w(tmp/sockets public/uploads)

# Bundle config
set :bundle_binary, "bundle"
set :bundle_flags,  "--deployment"

set :ssh_options, {
  forward_agent: true,
  paranoid: true,
  keys: "~/.ssh/id_rsa_prod"
}


# namespace :deploy do
#   desc 'Application-specific code after update_code'
#   after 'deploy:update_code' do
#     run %(
#       rm -f #{release_path}/config/database.yml &&
#       ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml
#         )

#     run %(
#       chgrp -R www #{release_path} &&
#       chmod -R o-rwx #{release_path}
#         )
#   end

#   task :start, roles: :app, except: { no_release: true } do
#     run "cd #{current_path} && #{try_sudo} #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D"
#   end
#   task :stop, roles: :app, except: { no_release: true } do
#     run "#{try_sudo} kill `cat #{unicorn_pid}`"
#   end
#   task :graceful_stop, roles: :app, except: { no_release: true } do
#     run "#{try_sudo} kill -s QUIT `cat #{unicorn_pid}`"
#   end
#   task :reload, roles: :app, except: { no_release: true } do
#     run "#{try_sudo} kill -s USR2 `cat #{unicorn_pid}`"
#   end
#   task :restart, roles: :app, except: { no_release: true } do
#     run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then #{try_sudo} kill -USR2 `cat #{unicorn_pid}`; else cd #{current_path} && #{try_sudo} #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D; fi"
#   end
# end

# Unicorn config
set :unicorn_binary, "unicorn"

after 'deploy:restart', 'deploy:cleanup'

# ################################
# # encoding: utf-8
# set :stages, %w(development testing production)
# set :default_stage, "production"

# set :application, "prod"

# set :git_application_name       , 'prod'
# set :deploy_to_application_name , application

# set :symlinks,  [
#                   { :label => :db, :path => 'config/database.yml' },
#                 ]

# # Capistrano config
# set :scm, :git
# set :copy_exclude, [".git"]
# set :deploy_via, :remote_cache
# set :normalize_asset_timestamps, false

# set :shared_children, shared_children + %w{public/uploads}

# # Bundle config
# set :bundle_binary, "bundle"
# set :bundle_flags,  "--deployment"

# set :ssh_options, {
#   forward_agent: true,
#   paranoid: true,
#   keys: "~/.ssh/id_rsa_prod"
# }

# require 'capistrano/ext/multistage'
# require "bundler/capistrano"
# # require "whenever/capistrano"
# require "delayed/recipes"

# # Unicorn config
# set :unicorn_binary, "unicorn"


# after "deploy:restart", "deploy:cleanup"
