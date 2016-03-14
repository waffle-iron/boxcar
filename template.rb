# Run using
# $ rails new APP_NAME -m smashing-template.rb

$path = File.expand_path(File.dirname(__FILE__))

def render_file(path)
  file = IO.read(path)
end

# -----------------------------
# GEMS
# -----------------------------
remove_file "Gemfile"
file 'Gemfile', render_file("#{$path}/files/Gemfile")

run 'bundle'
# Rspec
generate 'rspec:install'
# Factory_Girl
file 'spec/support/factory_girl.rb', render_file("#{$path}/files/factory_girl.rb")
# Database_Cleaner
file 'spec/support/database_cleaner.rb', render_file("#{$path}/files/database_cleaner.rb")
#Shoulda_Matchers
file 'spec/support/shoulda_matchers.rb', render_file("#{$path}/files/shoulda_matchers.rb")
# CodeClimate_Test_Reporter
inside 'spec' do
  inject_into_file 'spec_helper.rb', after: "# users commonly want.\n" do <<-RUBY
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
  RUBY
  end
end
# Tape
run 'tape installer install'
# Turbolinks
gsub_file 'app/assets/javascripts/application.js', /\/\/= require turbolinks/, ''
gsub_file 'app/views/layouts/application.html.erb', /, 'data-turbolinks-track' => true/, ""

# -----------------------------
# SETUP
# -----------------------------

# Remove test folder
remove_dir "test"

# Generate README.md
remove_file 'README.rdoc'
file 'README.md', render_file("#{$path}/files/README.md")
gsub_file 'README.md', /app_name/, app_name.upcase


# -----------------------------
# DATABASE
# -----------------------------
remove_file "config/database.yml"
file 'config/database.yml', render_file("#{$path}/files/database.yml")
gsub_file 'config/database.yml', /app_name/, app_name

# Add files for travis and linting
run "cp config/database.yml config/database.example.yml"
run "cp config/secrets.yml config/secrets.example.yml"

# Create travis.yml file
file '.travis.yml', render_file("#{$path}/files/.travis.yml")
gsub_file '.travis.yml', /app_name/, app_name

# Create rubocop linting file
file '.rubocop.yml', render_file("#{$path}/files/.rubocop.yml")

#Ignore all secrets and database config files
append_file '.gitignore' do <<-EOF

# Ignore all secrets and database config files
config/initializers/secret_token.rb
config/secrets.yml
config/database.yml
EOF
end

# -----------------------------
# GEM ADDITIONS (OPTIONAL)
# -----------------------------
# SmashingDocs
if yes?("Add SmashingDocs for API documentation?")
  smashing_docs = true
  inject_into_file 'Gemfile', after: "group :development, :test do\n" do <<-RUBY
  # Use smashing_docs for API documentation
  gem 'smashing_docs'
  RUBY
  end
end

# Devise
if yes?("Add Devise?")
  devise = true
  inject_into_file 'Gemfile', after: "gem 'taperole'\n" do <<-RUBY
gem 'devise'
  RUBY
  end
end

# ActiveAdmin
if yes?("Add ActiveAdmin?")
  active_admin = true
  gsub_file 'Gemfile', /^gem\s+["']devise["'].*$/,''
  inject_into_file 'Gemfile', after: "gem 'taperole'\n" do <<-RUBY
# Use activeadmin for admin interface
gem 'activeadmin', '~> 1.0.0.pre2'
gem 'devise'
  RUBY
  end
end

# Cucumber and Capybara
if yes?("Add Cucumber and Capybara?")
  cucumber_capybara = true
  inject_into_file 'Gemfile', after: "group :development, :test do\n" do <<-RUBY
  # Use cucumber-rails for automated feature tests
  gem 'cucumber-rails', :require => false
  # Use capybara-rails to simulate how a user interacts with the app
  gem 'capybara'
  RUBY
  end
end

run 'bundle' if smashing_docs || devise || active_admin || cucumber_capybara
generate 'docs:install' if smashing_docs
generate 'devise:install' if devise
generate 'active_admin:install' if active_admin
generate 'cucumber:install' if cucumber_capybara

# -----------------------------
# GIT
# -----------------------------
git :init
def run_bundle ; end
