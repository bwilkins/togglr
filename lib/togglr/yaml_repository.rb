#encoding: utf-8

module Togglr
  class YamlRepository < BaseRepository
    attr_reader :features

    def initialize
      @features = YAML.load(ERB.new(File.read(Togglr.configuration.yaml_repository_filename)))
    end

    def read(name)
      @features[name]
      
    end

    def write(name, value)
      
    end
  end
end
