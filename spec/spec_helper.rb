require 'capypage'
require 'capybara/rspec'

Capybara.app = lambda { |_|
  [200, { 'Content-Type' => 'application/html' }, File.read(File.join(File.dirname(__FILE__), 'sample_page.html'))]
}

class SamplePage < Capypage::Page
  set_url '/'

  element :header, 'header'
  elements :list, 'ul.list li' do |row|
    row.element :title, '.title'
    row.element :details, '.details'
  end

end