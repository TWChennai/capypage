module Capypage
  class Elements
    include Enumerable
    include Capypage::ElementProxy

    attr_reader :child_dsl_block, :child_selector, :base_element

    delegate :each, :size, :[],
             :to => :all

    def initialize(parent_selector, child_selector, options = {}, &block)
      @base_element   = Element.new(parent_selector, options)
      @child_selector = child_selector

      @child_dsl_block = block
    end

    def find_by_text(text, additional_options = {})
      additional_options[:text] = text
      construct child_selector, finder_options(additional_options)
    end

    def find_by_index(index)
      construct "#{child_selector}:nth-child(#{index + 1})", finder_options
    end

    def all(options = {})
      base_element.all(child_selector, options)
    end

    protected
    def capybara_element
      base_element
    end

    private
    def construct(selector, options)
      Element.new(selector, options).tap { |e| e.instance_eval &child_dsl_block }
    end

    def finder_options(options = {})
      options.merge(:base_element => base_element)
    end
  end
end
