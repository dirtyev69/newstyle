# production.rb
set :rails_env,      'production'
set :deploy_env,     :rails_env
set :bundle_without,  [:development, :test]

set :user, "rails"
set :group, "rails"
set :password, 'jekan777'

set :deploy_to_application_name , 'prod'

set :repo_url, "git@github.com:dirtyev69/newstyle.git"

set :branch, 'cap3'
set :deploy_to, "/var/www/prod"


set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"

# Настраиваем ssh до сервера
#set :gateway, "guest@dev-02.snpdev.ru:10332"
# server "5.101.99.155", :app, :web, :db, :primary => true
server "5.101.99.155", user: fetch(:user), group: fetch(:group), password: fetch(:password), roles: [:app, :web, :db],  :primary => true


# Используем rvm
set :using_rvm, true
set :rvm_ruby_string, 'ruby-2.2.1'
set :rvm_type, :user

# Авторизационные данные
# set :user, "rails"
# set :group, "rails"
# set :password, 'jekan777'

# Unicorn config
set :unicorn_config, "#{current_path}/config/unicorn.rb"


set :ssh_options, {
  forward_agent: true,
  paranoid: true,
  keys: "~/.ssh/id_rsa_prod"
}



# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server 'example.com', user: 'deploy', roles: %w{app db web}, my_property: :my_value
# server 'example.com', user: 'deploy', roles: %w{app web}, other_property: :other_value
# server 'db.example.com', user: 'deploy', roles: %w{db}



# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any  hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
