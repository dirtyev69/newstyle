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

# require 'whenever/capistrano'
# set :whenever_command, 'bundle exec whenever'

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
# namespace :deploy do
#   task :cope_with_git_repo_relocation do
#     run "if [ -d #{shared_path}/cached-copy ]; then cd #{shared_path}/cached-copy && git remote set-url origin #{repository}; else true; fi"
#   end
# end

# before "deploy:update_code", "deploy:cope_with_git_repo_relocation"

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
