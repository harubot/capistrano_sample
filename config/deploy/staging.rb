# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/capistrano_sample/capistrano_sample.staging'

# If the environment differs from the stage name
set :rails_env, 'staging'
