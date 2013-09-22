require 'active_support/core_ext/class/attribute'
require 'active_support/core_ext/hash/reverse_merge'

module Capypage
  class Page
    include Capybara::DSL
    class_attribute :url
    attr_reader :finder_options

    def initialize(prefix = nil, options = {})
      @finder_options = options.merge(:base_element => prefix ? Element.new(prefix, :base_element => Capybara.current_session) : Capybara.current_session)
    end

    class <<self
      def set_url(url)
        self.url = url
      end

      def element(name, selector, options = {})
        define_method(name) { Element.new(selector, finder_options.reverse_merge(options)) }
      end

      def elements(name, parent_selector, children_selector, options = {}, &block)
        define_method(name) { Elements.new(parent_selector, children_selector, finder_options.reverse_merge(options), &block) }
      end

      def section(name, section, selector, options = {})
        define_method(name) { section.new(selector, options) }
      end
    end

    def load
      visit self.class.url
    end
  end
end
