require_relative 'boot'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ChatSpace
  class Application < Rails::Application
    config.autoload_paths += Dir[Rails.root.join('app', 'uploaders')]
    config.i18n.default_locale = :ja
    config.generators do |g|
      g.helper false
      g.assets false
      g.test_framework false
    config.time_zone = 'Tokyo'
    end
  end
end
