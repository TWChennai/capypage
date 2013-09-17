require 'rubygems'
require 'bundler'
Bundler.require

require 'capybara/rspec'

Capybara.default_driver = :webkit

module DuckDuckGo
  class HomePage < Capypage::Page
    self.url = 'https://duckduckgo.com/'

    element :search_input, 'input[name=q]'
    element :search_button, 'input#search_button_homepage'

    def search(term)
      search_input.set term
      search_button.click
    end
  end

  class ResultsPage < Capypage::Page
    elements :results, '#links .results_links_deep' do |result|
      result.element :link, '.links_main a'
      result.element :snippet, '.snippet'
    end
  end
end