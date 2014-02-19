#encoding: utf-8

require 'togglr/base_repository'

module Togglr
  class YamlRepository < BaseRepository
    require 'erb'
    require 'yaml'

    def initialize(filename=nil)
      filename ||= Togglr.configuration.yaml_repository_filename
      @features = YAML.load(ERB.new(File.read(filename)).result)
    end

    def read(name)
      @features[name]
    end

    def write(name, value)
      # NOOP
    end

    private
    attr_reader :features
  end
end
