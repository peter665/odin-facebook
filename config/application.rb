require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module OdinFacebook
  class Application < Rails::Application
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'facebookconf.yml')
      YAML.load(File.open(env_file)).each do |k, v|
        ENV[k.to_s] = v
      end if File.exists?(env_file)
    end
  end
end
