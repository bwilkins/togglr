#encoding: utf-8

require 'active_record/base'

module Togglr
  module ActiveRecord
    class Toggle < ActiveRecord::Base
      table_name = 'togglr_toggles'

      validates_presence_of :name, :value
    end
  end
end
