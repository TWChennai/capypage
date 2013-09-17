module Capypage
  class Elements < Element
    include Enumerable
    attr_accessor :child_dsl_block

    delegate :each, :size, :[],
             :to => :all

    def initialize(selector, prefix = nil, options = {}, &block)
      super(selector, prefix, options)
      @child_dsl_block = block
    end

    def all(options = {})
      base_element.has_selector? element_selector
      base_element.all(element_selector, options.reverse_merge(finder_options))
    end

    def find(text, options = {})
      capybara_element options.merge(:text => text)
    end

    def find_by_text(text, options = {})
      Element.new(selector, prefix, finder_options.merge(options).merge(:text => text), &child_dsl_block)
    end

    def find_first(index = 1)
      Elements.new("#{element_selector}:nth-child(-n+#{index})", prefix, finder_options)
    end

    def find_last(index = 1)
      Elements.new("#{element_selector}:nth-last-child(-n+#{index})", prefix, finder_options)
    end

    def find_by_index(index)
      Element.new("#{element_selector}:nth-child(#{index + 1})", prefix, finder_options, &child_dsl_block)
    end
  end
end