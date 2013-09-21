require 'capypage'
require 'capybara/rspec'

Capybara.app = lambda { |_|
  [200, { 'Content-Type' => 'application/html' }, File.read(File.join(File.dirname(__FILE__), 'sample_page.html'))]
}

class PopupSection < Capypage::Section
  element :title, '.title'
end

class SamplePage < Capypage::Page
  set_url '/'

  element :header, 'header'
  element :missing_element, '.missing.element'
  element :invisble_element, '.invisible'

  elements :list, 'ul.list', 'li' do |row|
    row.element :title, '.title'
    row.element :details, '.details'
  end

  section :popup, PopupSection, '.popup'
end
