source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
gem 'pg' #postgresql db
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'devise'
gem 'slim-rails' #гем для Slim

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  #библиотека для написания тестов на BDD
  gem 'rspec-rails', '~> 3.0'
  gem 'capybara' #библиотека для удобного написания acceptance тестов
  gem 'selenium-webdriver' #гем для запуска js тестов
  gem 'database_cleaner' #гем для очистки базы(для ajax тестов) 
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

end

group :test do
  #библиотека для более короткой записи тестов ассоциаций, валидаций, etc 
  gem 'shoulda-matchers', '~> 3.0'
  #библиотека для более удобного написания тетовых данных
  gem 'factory_girl_rails'
  gem 'launchy' #библиотека генерации и показа страницы для более удобного дебагинга acceptance тестов
end