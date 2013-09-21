require 'spec_helper'

describe Capypage::Section do
  let(:page) { SamplePage.new }

  it 'should give the reference to the section' do
    popup = page.popup

    expect(popup.title).to have_text('Popup Title')
  end  
end
