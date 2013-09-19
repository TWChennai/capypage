require 'spec_helper'

describe Capypage::Element do
  let(:page) { SamplePage.new }

  before { page.load }

  it 'should delegate all capybara element methods' do
    expect(page.header[:class]).to eq('span12')
    expect(page.header).to have_text('Hello')
    expect(page.header).to_not have_text('Foo')
  end

end