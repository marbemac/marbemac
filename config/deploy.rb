require 'bundler/capistrano'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :rack_env, "production"
set :domain, '198.211.110.136'
set :application, 'marbemac'
set :repository,  'https://github.com/marbemac/marbemac.git'
set :branch,  'master'
set :deploy_to, "/var/www/#{application}"

set :scm, :git
set :scm_verbose, true

# roles (servers)
role :web, domain
role :app, domain
role :db,  domain, :primary => true

set :deploy_via, :remote_cache
set :use_sudo, false
set :keep_releases, 3
set :user, 'root'

set :bundle_without, [:development, :test]

set :rake, "#{rake} --trace"

set :default_environment, {
    'PATH' => "/usr/local/rvm/gems/ruby-1.9.3-p392/bin:/usr/local/rvm/gems/ruby-1.9.3-p392@global/bin:/usr/local/rvm/rubies/ruby-1.9.3-p392/bin:/usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games",
    'RUBY_VERSION' => 'ruby 1.9.3',
    'GEM_HOME'     => '/usr/local/rvm/gems/ruby-1.9.3-p392@marbemac',
    'GEM_PATH'     => '/usr/local/rvm/gems/ruby-1.9.3-p392:/usr/local/rvm/gems/ruby-1.9.3-p392@global:/usr/local/rvm/gems/ruby-1.9.3-p392@marbemac',
    'BUNDLE_PATH'  => '/usr/local/rvm/gems/ruby-1.9.3-p392@marbemac'  # If you are using bundler.
}

after 'deploy:setup' do
  sudo "chown -R #{user} #{deploy_to} && chmod -R g+s #{deploy_to}"
end

namespace :deploy do
  desc "Restart Passenger"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end