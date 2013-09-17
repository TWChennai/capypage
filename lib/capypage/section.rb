module Capypage
  class Section < Page
    alias_method :selector, :prefix
  end
end