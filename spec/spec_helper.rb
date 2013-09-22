require 'capypage'
require 'capybara/rspec'
require 'sinatra/base'

class TestApp < Sinatra::Base
  get '/' do
    File.read(File.join(File.dirname(__FILE__), 'html', 'sample_page.html'))
  end

  get '/echo/:input' do
    "<p class='echo'>#{params[:input]}</p>"
  end
end

Capybara.app = TestApp.new

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

class EchoPage < Capypage::Page
  set_url '/echo/:input'

  element :content, 'p.echo'
end
