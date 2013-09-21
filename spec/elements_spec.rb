require 'spec_helper'

describe Capypage::Elements do
  let(:page) { SamplePage.new }
  let(:elements) { page.list }
  before { page.load }

  it 'should find the collection of elements matching' do
    expect(elements.size).to eq(3)
  end

  describe '#find_by_text' do
    it 'should find the element with text within the collection' do
      element = elements.find_by_text('Title 1')
      expect(element.details.text).to eq('Details 1')
    end

    it 'should look up the element in parent selector' do
      element = elements.find_by_text 'Hello'
      expect(element.base_element).to_not eq(Capybara.current_session)
      expect(element.base_element.selector).to eq('ul.list')
    end
  end

  describe 'delegation of capybara methods to the collection' do
    it 'should delegate has_text' do
      expect(elements).to have_text('Title 1')
    end
  end

end
