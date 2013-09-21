module Capypage
  class Elements < Element
    include Enumerable
    attr_accessor :child_dsl_block

    delegate :each, :size, :[],
             :to => :all

    def initialize(parent_selector, children_selector, prefix = nil, options = {}, &block)
      parent_selector_options = options.merge :base_element => Element.new(parent_selector, prefix, options)

      super(children_selector, prefix, parent_selector_options)
      @child_dsl_block = block
    end

    def find_by_text(text, options = {})
      Element.new(selector, prefix, finder_options.merge(options).merge(:text => text), &child_dsl_block)
    end

    def find_by_index(index)
      Element.new("#{element_selector}:nth-child(#{index + 1})", prefix, finder_options, &child_dsl_block)
    end

    private
    def all(options = {})
      base_element.all(element_selector, capybara_finder_options(options))
    end

  end
end
