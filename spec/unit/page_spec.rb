require 'spec_helper'

describe Capypage::Page do
  let(:page) { SamplePage.new }
  let(:current_session) { Capybara.current_session }

  context 'page loading' do
    context 'complete url' do
      it 'should load the page' do
        current_session.should_receive(:visit).with(SamplePage.url)
        page.load
      end
    end

    context 'dynamic url' do
      it 'should load the page with the options substituted' do
        page = EchoPage.visit :input => 'Hello'
        expect(page.current_url).to end_with '/echo/Hello'
        expect(page.content.text).to eq('Hello')
      end

      it 'should be able to handle different values for the substitution' do
        expect(EchoPage.visit(:input => 'world').current_url).to end_with '/echo/world'
      end
    end
  end

  describe 'dsl' do
    before { page.load }

    describe '.element' do
      it 'should return the element matching the selector' do
        expect(page.header.text).to eq('Hello World!')
      end
    end

    describe '.elements' do
      let(:elements) { page.list }

      it 'should return the size collection' do
        expect(elements.size).to eq(3)
      end

      it 'should return the element in the collection and its details' do
        expect(elements.find_by_index(0).title.text).to eq('Title 1')
      end
    end
  end

end
