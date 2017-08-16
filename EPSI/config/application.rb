require_relative 'boot'

require 'rails/all'
require 'packetfu'
include PacketFu


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Websec
  class Application < Rails::Application
  	include PacketFu
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
