set :application, "point.kg"
role :app, 'point.kg'
role :web, 'point.kg'
role :db,  'point.kg', :primary => true

set :user, "point"
set :deploy_to, "/home/point/#{application}"
set :use_sudo, false

set :scm, "git"
set :repository, "git://github.com/tmedetbekov/municipality.git"
set :branch, "point.kg"

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'
