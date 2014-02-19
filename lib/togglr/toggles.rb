#encoding: utf-8

require 'togglr/base_feature'
require 'togglr/yaml_reader'

module Togglr
  class Toggles

    def self.register_features
      authoritative_repository.features.each do |name, value|
        register_feature(name, value)
      end
    end

    private
      def self.register_feature(name, properties)
        f = BaseFeature.new(name, properties[:value], repositories)
        define_singleton_method("#{name}?") do
          f.active?
        end

        define_singleton_method("#{name}=") do |new_value|
          f.active = new_value
        end
      end

      def self.authoritative_repository
        YamlReader.new
      end

      def self.repositories
        Togglr.configuration.repositories.map do |repo|
          get_class(repo).new
        end
      end

      def self.get_class(class_name)
        class_name.split('::').inject(Object) do |mod, name|
          mod.const_get(name)
        end
      end
  end
end
