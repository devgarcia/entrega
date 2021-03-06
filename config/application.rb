require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Entrega
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.i18n.available_locales = [:en, :es]
    config.i18n.default_locale = :en

    # Added to get the modules on models
    config.autoload_paths += %W(#{config.root}/lib)

    # Code below sets environment variables from local_env.yml file.
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end

    config.action_mailer.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    user_name: ENV["GMAIL_USERNAME"],
    password:  ENV["GMAIL_PASSWORD"],
    authentication: :plain,
    enable_starttls_auto: true,
    domain: 'gmail.com'  # Added to see if it will work after a block by Google
    }   
  end  
end
