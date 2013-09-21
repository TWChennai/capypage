require 'spec_helper'

describe Capypage::Element do
  let(:page) { SamplePage.new }

  before { page.load }

  it 'should delegate all capybara element methods' do
    expect(page.header[:class]).to eq('span12')
    expect(page.header).to have_text('Hello')
    expect(page.header).to_not have_text('Foo')
  end

  describe '#present?' do
    it 'should be true for elements which are present' do
      expect(page.header).to be_present
      expect(page.missing_element).to_not be_present
    end
  end

  describe '#visible?' do
    it 'should be true for elements which are visible' do
      expect(page.header).to be_visible
      expect(page.invisble_element).to_not be_visible
    end
  end
end
