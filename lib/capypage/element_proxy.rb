require 'active_support/concern'

module Capypage
  module ElementProxy
    extend ActiveSupport::Concern

    included do
      delegate *capybara_element_methods,
               :to => :capybara_element
    end

    module ClassMethods
      def capybara_element_methods
        # TODO: Is this really required?
        Capybara::Node::Element.instance_methods - Object.methods - instance_methods
      end
    end

  end
end