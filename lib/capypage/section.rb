module Capypage
  class Section
    include Capybara::DSL
    attr_reader :finder_options

    def initialize(options = {})
      prefix          = options.delete(:prefix)
      @finder_options = options.merge(:base_element => prefix ? Element.new(prefix, :base_element => Capybara.current_session) : Capybara.current_session)
    end

    class <<self
      def element(name, selector, options = {})
        define_method(name) { Element.new(selector, finder_options.reverse_merge(options)) }
      end

      def elements(name, parent_selector, children_selector, options = {}, &block)
        define_method(name) { Elements.new(parent_selector, children_selector, finder_options.reverse_merge(options), &block) }
      end

      def section(name, section, selector, options = {})
        define_method(name) { section.new(options.merge :prefix => selector) }
      end
    end
  end
end
