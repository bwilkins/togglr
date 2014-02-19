#encoding: utf-8

module Togglr
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end

  class Configuration
    attr_accessor :features_file, :repositories

    def initialize
      @features_file = 'togglr.yml'
      @repositories = []
    end
  end
end

require 'togglr/version'
