require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module I18nApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Загрузка пути к нашим кастомным локалям. Rails.root возвращает весь путь к корню приложения
    # config.i18n.load_path += Dir[Rails.root.join('custom_locales', '*.{yml}')]

    # Chain - это связка двух бэкендов. Будут использоваться оба, в зависимости от потребностей.
    # config.i18n.backend =
    # I18n::Backend::Chain.new(I18n::Backend::ActiveRecord.new, I18n.backend)

    # указываем локали, которые разрешаем исп-зовать в приложении. Если приходящая локаль в запросе
    # соответствует поддерживаемым языкам, то ставим её, если нет - юзаем дефолтную!
    config.i18n.available_locales = %i[en ru]
    config.i18n.default_locale = :en
  end
end
