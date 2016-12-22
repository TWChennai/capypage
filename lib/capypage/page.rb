require 'active_support/core_ext/class/attribute'
require 'active_support/core_ext/hash/reverse_merge'

module Capypage
  class Page < Section
    class_attribute :url
    attr_reader :url_options

    def initialize(options = {})
      @url_options    = options.delete(:url_options) || {}
      super(options)
    end

    class <<self
      def set_url(url)
        self.url = url
      end

      def visit(url_options = {})
        new(:url_options => url_options).tap &:load
      end
    end

    def load
      visit url.dup.tap{ |page_url|  url_options.each { |k, v| page_url.gsub!(":#{k}", v) }}
    end
  end
end
