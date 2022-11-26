# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

class Hacker
  class << self
    def hack(email, password)
      # BEGIN
      host = 'https://rails-collective-blog-ru.hexlet.app'
      sign_up_url = "#{host}/users/sign_up"
      users_url = "#{host}/users"
      sign_up_page = URI.parse(sign_up_url).open
      html_document = Nokogiri::HTML(sign_up_page)
      token = html_document.at('input[type="hidden"]')['value']
      cookie = sign_up_page.meta['set-cookie']
      uri = URI.parse(users_url)
      params = {
        authenticity_token: token,
        email: email,
        password: password,
        password_confirmation: password
      }
      headers = { 'Cookie' => cookie }
      response = Net::HTTP.post(URI.parse(users_url), params.to_query, headers)
      case response
      when Net::HTTPSuccess, Net::HTTPRedirection
        response
      else
        raise 'Request failed'
      end
      # END
    end
  end
end
