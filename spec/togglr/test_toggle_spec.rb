# encoding: utf-8

require_relative '../spec_helper'
require 'togglr/test_toggle'

module Togglr
  describe TestToggle do

    it 'by default raises an exception when checked' do
      expect { Togglr::TestToggle.new(:foobar, false, []).active? }.to raise_error
    end

  end
end
