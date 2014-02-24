#encoding: utf-8

module Togglr
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end

  def self.log(msg)
    configuration.logger.info(msg) if configuration.logger
  end

  class Configuration
    attr_accessor :toggles_file, :repositories, :logger

    def initialize
      @toggles_file = File.join('config', 'togglr.yml')
      @repositories = []
    end
  end
end

require 'togglr/version'
