# config valid only for current version of Capistrano
lock "3.8.1"

server '45.79.135.198', port: 3000, roles: [:web, :app, :db], primary: true


set :repo_url,        'git@github.com:Henrik41/nodetest2.git'
set :application,     'testnode2'
set :user,            'bob'

## Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"

set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }

namespace :deploy do

  desc 'Restart application'
  task :restart do
    invoke 'pm2:restart'
  end

  after :publishing, :restart   
end
