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
    attr_accessor :toggles_file, :repositories, :logger, :test_mode

    def initialize
      @toggles_file = File.join('config', 'togglr.yml')
      @repositories = []
      @logger = Rails.logger if defined?(Rails)
    end

    def test_mode?
      @test_mode ||= false
    end

    def test_mode!
      @test_mode = true
    end
  end
end

require 'togglr/version'
