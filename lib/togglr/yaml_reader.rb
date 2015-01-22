module Togglr
  class YamlReader
    require 'erb'
    require 'yaml'

    attr_reader :categorised_toggles

    def initialize(filename)
      @categorised_toggles = YAML.load(ERB.new(File.read(filename)).result).freeze
    end

    def toggles
      categorised_toggles.keys.inject({}) do |toggle_set, category|
        categorised_toggles[category].each do |toggle_name, toggle_properties|
          toggle_properties[:category] = category
        end.merge(toggle_set)
      end
    end

  end
end
