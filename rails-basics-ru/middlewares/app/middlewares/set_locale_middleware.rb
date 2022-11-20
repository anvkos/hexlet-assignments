# frozen_string_literal: true

class SetLocaleMiddleware
  def initialize(app)
    @app = app
  end

  # BEGIN
  def call(env)
    locale_from_headers = extract_locale_from_headers(env)
    Rails.logger.debug("Locale in header: #{locale_from_headers}")

    if locale_from_headers && I18n.available_locales.include?(locale_from_headers.to_sym)
      Rails.logger.debug("Locale #{locale_from_headers} from header available.")
      I18n.locale = locale_from_headers
    else
      Rails.logger.debug("Locale from headers(#{locale_from_headers}) is not set or available, using default: #{I18n.default_locale}")
      I18n.locale = I18n.default_locale
    end

    status, headers, response = @app.call(env)
    [status, headers, response]
  end

  def extract_locale_from_headers(env)
    env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first
  end
  # END
end
