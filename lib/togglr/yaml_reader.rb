#encoding: utf-8

module Togglr
  class YamlReader
    require 'erb'
    require 'yaml'

    def initialize(filename)
      @toggles = YAML.load(ERB.new(File.read(filename)).result).freeze
    end

    attr_reader :toggles
  end
end
