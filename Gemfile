source 'https://rubygems.org'

# bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'

# becaue Heroku only supports Postgres, so need to use 'pg' in the Production environment
group :production do
  gem 'pg'
  # need to install asset pipeline
  # this purpose is to make Rails apps fast by default and allow developer to write 'assets' (image, styles, JS) in other languages
  # Rails 4.x.x need some changes to properly serve assets on Heroku
  # add this code to make some changes and install it into our application 'bundle'
  gem 'rails_12factor'
end

# specify 'sqlite3' database for be our Development environment
# sqlite3 is easy to use and perfext for rapid testing
group :development do
  gem 'sqlite3'
end

# add the gem to Gemfile for the RSpec Test
# this code lets the 'tasks' and 'generators' of 'rspec-rails' are available for both ':development' and ':test'
# use '~> x.x' to choose specified version
# use 'bundle' to install RSpec, then 'rails generate rspec:install' to configure the project for testing
group :development, :test do
  gem 'rspec-rails', '~> 3.0'
end

# use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# use jquery as the JavaScript library
gem 'jquery-rails'
# turbolinks makes following links in your web application faster. Read more! https://github.com/rails/turbolinks
gem 'turbolinks'

# because the Gemfile has been changed, so need to type 'bundle install --without productiob' in the Terminal's command line
# this command will installs everything specified in the 'Gemfile' and ensures that all gems work well
# '--without production' is to ignores all gems which in 'group :production'
# this Production environment will automatically run 'bundle install' when we deploy, and it will account for gems declared in 'group :production at that point'
# need to type 'rake db:create' to create a new local database, need to use this command everytime after we create a new app or dropping an existing database

# Heroku's URL 'https://devcenter.heroku.com/articles/rails-4-asset-pipeline'

# for Cloud9, need to use 'rails s -p $PORT -b $IP' on the Terminal before run the Rails server 'rails s'

# to use Heroke, enter below codes in termainal: 'heroku create' use to create a name for project, 'git push heroku master' use to push code from git repository to Heroku

# if close the windows before shutdown Rails server, use 'rails s -p $PORT -b $IP -d' to simulate losing track of Rails server, '-d' options will stars the Rails server as a backgroung process
# use 'lsof -i:$PORT' to find PID
# at last, use 'kill -9 PID' to kill the server

# for MVC, use 'rails generate controller welcome index about' to generate all necessary files
# there're three arguments for 'rails': 'welcome' - name of controller, 'index' and 'about' - are views