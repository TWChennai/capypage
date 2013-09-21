require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/object/blank'

module Capypage
  class Element
    attr_accessor :selector, :finder_options, :base_element

    def initialize(selector, options = {}, &block)
      options.reverse_merge! :match => :first
      @finder_options = options.clone
      @selector = selector
      @base_element = finder_options[:base_element]
      block.call(self) if block.present?
    end

    def element(name, selector, options = {})
      base = self
      define_singleton_method(name) { Element.new(selector, options.reverse_merge!(:match => :first, :base_element => base)) }
    end

    def elements(name, selector, options = {}, &block)
      base = self
      define_singleton_method(name) { Elements.new(selector, options.reverse_merge!(:base_element => base), &block) }
    end

    def present?
      base_element.has_selector? element_selector, capybara_finder_options
    end

    def visible?(options = {})
      return capybara_element(options).visible?
    rescue Capybara::ElementNotFound
      false
    end

    protected
    def capybara_element(options = {})
      base_element.find(element_selector, capybara_finder_options(options))
    end

    def element_selector
      selector
    end

    def capybara_finder_options(options = {})
      finder_options_without_base = finder_options.clone
      finder_options_without_base.delete(:base_element)
      options.reverse_merge finder_options_without_base
    end

    def self.capybara_element_methods
      Capybara::Node::Element.instance_methods - Object.methods - [:visible?]
    end

    delegate *capybara_element_methods,
             :to => :capybara_element
  end
end
