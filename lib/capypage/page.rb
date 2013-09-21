require 'active_support/core_ext/class/attribute'
require 'active_support/core_ext/hash/reverse_merge'

module Capypage
  class Page
    include Capybara::DSL
    class_attribute :url
    attr_accessor :prefix, :finder_options

    def initialize(prefix = nil, options = {})
      @prefix = prefix
      @finder_options = options
    end

    class <<self
      def set_url(url)
        self.url = url
      end

      def element(name, selector, options = {})
        options.reverse_merge! :match => :first
        define_method(name) { Element.new(selector, prefix, options) }
      end

      def elements(name, parent_selector, children_selector, options = {}, &block)
        define_method(name) { Elements.new(parent_selector, children_selector, prefix, options, &block) }
      end

      def section(name, section, selector, options = {})
        define_method name do
          section.new(selector, options)
        end
      end
    end

    def load
      visit self.class.url
    end
  end
end
