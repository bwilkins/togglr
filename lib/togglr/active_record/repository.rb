#encoding: utf-8

require 'togglr/base_repository'
require 'togglr/active_record/toggle'

module Togglr
  module ActiveRecord
    class Repository < Togglr::BaseRepository

      def read(name)
        toggle = Togglr::ActiveRecord::Toggle.find_by(name: name)
        return toggle.value if toggle.present?
        nil
      end
      def write(name, new_value)
        Togglr::ActiveRecord::Toggle.find_or_initialize_by(name: name).update_attribute(:value, new_value)
        new_value
      end

    end
  end
end
