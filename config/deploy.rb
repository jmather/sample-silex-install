set :application, "My Project"
set :repository,  "ssh://git@example.com/repository"

set :scm, :git
set :deploy_via, :remote_cache

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

server 'example.com', :app, :web, :db, :primary => true
set :domain,      "example.com"
set :deploy_to,   "/home/user/site"
set :user, "username"
set :port, 22

set  :keep_releases,  3
set :shared_children,     ["log", "config/config.php"]


set :group_writable, false
set :use_sudo, false

set :php_bin, "/usr/local/bin/php"

ssh_options[:forward_agent] = true
set :phpunit_bin, "/usr/local/bin/phpunit"


after "deploy", "deploy:cleanup"
after "deploy:update_code", "composer:install"
before "composer:install", "composer:copy_vendors"
after "composer:install", "phpunit:run_tests"

namespace :composer do
  desc "Copy vendors from previous release"
  task :copy_vendors, :except => { :no_release => true } do
    run "if [ -d #{previous_release}/vendor ]; then cp -a #{previous_release}/vendor #{latest_release}/vendor; fi"
  end
  task :install do
    run "sh -c 'cd #{latest_release} && curl -s http://getcomposer.org/installer | #{php_bin}'"
    run "sh -c 'cd #{release_path} && ./composer.phar install'"
  end
end

namespace :phpunit do
  desc "Test before making live"
  task :run_tests, :roles => :app do
    run "cd #{latest_release} && #{phpunit_bin}"
  end
end
