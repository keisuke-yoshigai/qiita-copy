require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module QiitaCopy
  class Application < Rails::Application
    config.i18n.default_locale = :ja
      config.time_zone = 'Asia/Tokyo'
      config.active_record.default_timezone = :local

    config.generators do |g|
      g.javascripts false
      g.helper false
      g.test_framework false
      g.stylesheets false
    end
  end
end
