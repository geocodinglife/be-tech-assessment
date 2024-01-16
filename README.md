# Step 1: Install Required Gems
bundle install

# Step 2: Create and Migrate the Test Database
# Ensure your test database is set up by running:
rails db:test:prepare
rails db:migrate RAILS_ENV=test

# Step 3: Run RSpec
bundle exec rspec