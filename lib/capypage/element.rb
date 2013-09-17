require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/object/blank'

module Capypage
  class Element
    attr_accessor :selector, :prefix, :finder_options, :base_element

    delegate :click, :set, :text, :all, :find, :[], :native, :disabled?, :selected?, :has_text?, :has_no_text?, :checked?, :has_selector?,
             :to => :capybara_element

    def initialize(selector, prefix = nil, options = {}, &block)
      options.reverse_merge! :match => :smart
      @selector = selector
      @prefix = prefix
      @finder_options = options
      @base_element = options.delete(:base_element) || Capybara.current_session
      block.call(self) if block.present?
    end

    def element(name, selector, options = {})
      base = self
      define_singleton_method(name) { Element.new(selector, prefix, options.reverse_merge!(:match => :first, :base_element => base)) }
    end

    def elements(name, selector, options = {}, &block)
      base = self
      define_singleton_method(name) { Elements.new(selector, prefix, options.reverse_merge!(:base_element => base), &block) }
    end

    def visible?(options = {})
      options.reverse_merge! finder_options
      options.reverse_merge! :wait => 2
      return capybara_element(options).visible?
    rescue Capybara::ElementNotFound
      false
    end

    protected
    def capybara_element(options = {})
      base_element.find(element_selector, options.reverse_merge(finder_options))
    end

    def element_selector
      [prefix, selector].compact.join(" ")
    end
  end
end
