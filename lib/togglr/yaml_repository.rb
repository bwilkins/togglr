#encoding: utf-8

require 'togglr/base_repository'

module Togglr
  class YamlRepository < BaseRepository
    require 'erb'
    require 'yaml'

    attr_reader :features

    def initialize
      @features = YAML.load(ERB.new(File.read(Togglr.configuration.yaml_repository_filename)))
    end

    def read(name)
      @features[name]
    end

    def write(name, value)
      # NOOP
    end
  end
end
