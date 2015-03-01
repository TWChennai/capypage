require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/object/blank'

module Capypage
  ##
  # Represents a single element in a page. Can be div, image, anchor or anything, which can be identified by selector.

  class Element
    include Capypage::ElementProxy

    attr_reader :selector, :finder_options, :base_element, :select_using

    # Creates an element
    # @param [String] selector to identify element
    # @param [Hash] options
    # @option options [Capypage::Element] :base_element Base element for the element to be created
    # @option options [Symbol] :select_using Selector to switch at element level
    def initialize(selector, options = {})
      @finder_options = options.reverse_merge :match => :first
      @selector       = selector
      @base_element   = finder_options.delete(:base_element)
      @select_using   = finder_options.delete(:select_using) || Capybara.default_selector
    end

    def element(name, selector, options = {})
      define_singleton_method(name) { Element.new(selector, options.merge(:base_element => self)) }
    end

    def elements(name, selector, options = {}, &block)
      define_singleton_method(name) { Elements.new(selector, options.merge(:base_element => self), &block) }
    end

    def present?
      base_element.has_selector? selector, finder_options
    end

    def not_present?
      base_element.has_no_selector? selector, finder_options
    end

    def visible?(options = {})
      capybara_element(options).visible?
    rescue Capybara::ElementNotFound
      false
    end

    protected
    def capybara_element(options = {})
      base_element.find(select_using, selector, options.reverse_merge(finder_options))
    end
  end
end
