#encoding: utf-8

require 'togglr/version'
require 'togglr/yaml_repository'
require 'togglr/toggles'

module Togglr
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end

  class Configuration
    attr_accessor :yaml_repository_filename, :repositories, :authoritative_repository

    def initialize
      @yaml_repository_filename = 'togglr.yml'
      @authoritative_repository = 'Togglr::YamlRepository'
      @repositories = ['Togglr::YamlRepository']
    end
  end
end
