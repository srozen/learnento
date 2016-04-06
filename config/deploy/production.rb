set :stage, :production

# Replace 127.0.0.1 with your server's IP address!
server '46.101.155.249', user: 'deploy', roles: %w{web app db}

#application information
set :branch,    "master"
set :deploy_to, "/home/deploy/learnento"
set :rails_env, "production"
