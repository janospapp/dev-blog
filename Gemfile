source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem "tailwindcss-rails", "~> 3.3"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Required by Rodauth
gem "bcrypt", "~> 3.1"
gem "redcarpet", "~> 3.6"
gem "rodauth-rails", "~> 2.0"
gem "sequel-activerecord_connection", "~> 2.0"
gem "tilt", "~> 2.4"

gem "heroicon", "~> 1.0"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false

  gem "dotenv", "~> 3.1"
  gem "factory_bot_rails", "~> 6.4"
  gem "rspec-rails", "~> 7.1"
  gem "rubocop-rspec", "~> 3.3"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Use a fork until Rails 8 support is merged and released in the official Gem
  gem "annotate", git: "https://github.com/tnir/annotate_models.git", branch: "rails-8"
end

group :test do
  gem "faker", "~> 3.5"
  gem "rails-controller-testing", "~> 1.0"
  gem "shoulda-matchers", "~> 6.4"
end

gem "inline_svg", "~> 1.10"
