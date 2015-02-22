require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara-screenshot/rspec'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    inspector: true,
    js_errors: true
  )
end

Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|
  config.include Capybara::Angular::DSL, type: :feature
end
