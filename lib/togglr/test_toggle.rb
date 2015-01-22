require 'togglr/base_toggle'

module Togglr
  class TestToggle < BaseToggle
    private
    def default_value
      raise StandardError, "No expected value set for toggle #{@name}. You must declare values for toggles in test!"
    end
  end
end
