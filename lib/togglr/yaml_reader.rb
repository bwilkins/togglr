#encoding: utf-8

module Togglr
  class YamlReader
    require 'erb'
    require 'yaml'

    def initialize(filename=nil)
      filename ||= Togglr.configuration.features_file
      @features = YAML.load(ERB.new(File.read(filename)).result).freeze
    end

    attr_reader :features
  end
end
