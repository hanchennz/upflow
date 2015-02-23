RSpec.configure do |config|
  config.include Warden::Test::Helpers, type: :feature
  Warden.test_mode!

  config.after(type: :feature) do
    Warden.test_reset!
  end
end
