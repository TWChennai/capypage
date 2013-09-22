require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/object/blank'

module Capypage
  class Element
    include Capypage::ElementProxy

    attr_reader :selector, :finder_options, :base_element

    def initialize(selector, options = {}, &block)
      @finder_options = options.reverse_merge :match => :first
      @selector = selector
      @base_element = finder_options[:base_element]

      block.call(self) if block.present?
    end

    def element(name, selector, options = {})
      base = self
      define_singleton_method(name) { Element.new(selector, options.merge(:base_element => base)) }
    end

    def elements(name, selector, options = {}, &block)
      base = self
      define_singleton_method(name) { Elements.new(selector, options.merge(:base_element => base), &block) }
    end

    def present?
      base_element.has_selector? selector, capybara_finder_options
    end

    def visible?(options = {})
      capybara_element(options).visible?
    rescue Capybara::ElementNotFound
      false
    end

    protected
    def capybara_element(options = {})
      base_element.find(selector, capybara_finder_options(options))
    end

    def capybara_finder_options(options = {})
      finder_options_without_base = finder_options.clone
      finder_options_without_base.delete(:base_element)
      options.reverse_merge finder_options_without_base
    end

    include Capypage::ElementProxy
  end
end
