require 'rubygems'
require 'bundler'
Bundler.require
require 'capybara/rspec'

CAPABILITIES = {
    'browserName' => 'iOS',
    'platform' => 'Mac',
    'version' => '6.0',
    'app' => absolute_app_path
}


Capybara.default_driver = :webkit


module DuckDuckGo
  class Safari < Capypage::Page
    set_url 'https://duckduckgo.com/'

    element :search_input, 'input[name=q]'
    element :search_button, 'input#search_button_homepage'

    def search(term)
      search_input.set term
      search_button.click
    end
  end
end
