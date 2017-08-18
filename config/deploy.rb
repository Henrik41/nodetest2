# config valid only for current version of Capistrano
lock "3.8.2"

server '45.79.135.198', roles: [:web, :app], primary: true


set :repo_url,        'git@github.com:Henrik41/nodetest2.git'
set :application,     'index'
set :user,            'bob'

## Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/var/www/nodetest2"
set :pm2_app_command, 'index.js'
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }


namespace :deploy do
  desc 'Restart application'
  task :restart do
    # invoke 'npm:install'
    invoke 'pm2:restart'
  end

  after :publishing, :restart
end


