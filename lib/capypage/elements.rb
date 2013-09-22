module Capypage
  class Elements
    include Enumerable
    include Capypage::ElementProxy

    attr_reader :child_dsl_block, :child_selector, :base_element

    delegate :each, :size, :[],
             :to => :all

    def initialize(parent_selector, child_selector, options = {}, &block)
      @base_element = Element.new(parent_selector, options)
      @child_selector = child_selector

      @child_dsl_block = block
    end

    def find_by_text(text, options = {})
      Element.new(child_selector, options.merge(finder_options(:text => text)), &child_dsl_block)
    end

    def find_by_index(index)
      Element.new("#{child_selector}:nth-child(#{index + 1})", finder_options, &child_dsl_block)
    end

    protected
    def capybara_element
      base_element
    end

    private
    def all(options = {})
      base_element.all(child_selector, options)
    end

    def finder_options(options = {})
      options.merge(:base_element => base_element)
    end
  end
end
