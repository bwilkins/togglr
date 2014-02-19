#encoding: utf-8

require 'togglr/base_feature'

module Togglr
  class Toggles

    def self.register_features
      authoritative_repository.features.each do |name, value|
        register_feature(name, value)
      end
    end

    def self.register_feature(name, default_state)
      f = BaseFeature.new(name, default_state, repositories)
      define_method("#{name}?") do
        f.active?
      end

      define_method("#{name}=") do |new_value|
        f.active = new_value
      end
    end


    private
      def self.authoritative_repository
        get_class(Togglr.configuration.authoritative_repository).new
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

      register_features
  end
end
