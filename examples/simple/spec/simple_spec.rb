require 'spec_helper'

describe 'Simple example', :type => :feature do
  let(:search_page) { DuckDuckGo::HomePage.new }
  let(:search_results_page) { DuckDuckGo::ResultsPage.new }

  it 'should show capybara results' do
    search_page.load
    search_page.search 'Capybara'

    capybara_result = search_results_page.results.find_by_text 'jnicklas'
    expect(capybara_result.link[:href]).to eq('https://github.com/jnicklas/capybara')
    expect(capybara_result.snippet).to have_text('Capybara helps you test web applications')
  end
end