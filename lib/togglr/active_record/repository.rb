require 'togglr/base_repository'
require 'togglr/active_record/toggle'

module Togglr
  module ActiveRecord
    class Repository < Togglr::BaseRepository

      def read(name)
        toggle = Togglr::ActiveRecord::Toggle.get(name)
        return toggle.value if toggle.present?
        nil
      end

      def write(name, new_value)
        toggle = Togglr::ActiveRecord::Toggle.set(name, new_value)
        toggle.value
      end

    end
  end
end
