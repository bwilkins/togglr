#encoding: utf-8

require 'active_record/base'

module Togglr
  module ActiveRecord
    class Toggle < ::ActiveRecord::Base
      self.table_name = 'togglr_toggles'
      self.primary_key = 'name'

      validates_presence_of :name
      validates_uniqueness_of :name
      validates_inclusion_of :value, in: [true, false]

      def self.set(name, value)
        toggle = get(name)
        toggle = new.tap { |t| t.name = name } if toggle.nil?
        toggle.value = value
        toggle.save!
        toggle
      end

      def self.get(name)
        where(name: name).first
      end
    end
  end
end
