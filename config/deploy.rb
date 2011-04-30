set :user, 'ec2-user'
set :server, 'hushi.familybird.com'
set :application, 'hushi'
set :repository,  "git@github.com:adambird/#{application}.git"
ssh_options[:forward_agent] = true
ssh_options[:keys] = [File.join(ENV["HOME"], "adambirdkey.pem")]

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/apps/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :app, "hushi.familybird.com"
role :web, "hushi.familybird.com"
role :db,  "hushi.familybird.com", :primary => true

set :deploy_via, :remote_cache
set :scm, 'git'
set :branch, 'master'
set :scm_verbose, true
set :use_sudo, false
set :copy_exclude, [".git", "spec"]

namespace :deploy do
  desc "Cause Passenger to initiate a restart"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
  desc "reload the databse with seed data"
  task :seed do
    run "cd #{current_path}; rake db:seed RAILS_ENV=production"
  end
end

after "deploy:update_code", :bundle_install
desc "install the necessary prerequisites"
task :bundle_install, :roles => :app do
  run "cd #{release_path} && bundle install"
end