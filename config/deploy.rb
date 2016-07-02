# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'capistrano_sample'
set :repo_url, 'git@github.com:qooskydev/capistrano_sample.git'

# Default branch is :master
set :branch, 'master'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {} (↓rbenvがシステムインストールされている場合)
set :default_env, { path: "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

# rbenvの設定 (/usr/local/rbenv に 2.1.2 をインストールすることを想定)
set :rbenv_type, :system
set :rbenv_ruby, '2.1.2'

# bundlerを実行する際の引数
set :bundle_flags, "--deployment --without development test"
#set :bundle_flags, "--deployment --without development test --local"

# サーバ設定
set :password, ask('Server password', nil)
server '192.168.56.11', user: 'capcap', port: 22, password: fetch(:password), roles: %w{web app db}


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

