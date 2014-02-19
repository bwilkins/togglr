#encoding: utf-8

require 'togglr/base_feature'

module Togglr
  class Toggles

    def self.register_features
      authoritative_repository.features.each do |feature|
        register_feature(feature)
      end
    end

    def self.register_feature(feature)
      f = BaseFeature.new(feature[:name], feature[:default_state])
      define_method("#{feature}?") do
        f.active?
      end

      define_method("#{feature}=") do |new_value|
        f.active = new_value
      end
    end


    private
      def self.authoritative_repository
        create_instance_of Togglr.configuration.authoritative_repository
      end

      def repositories
        @repositories ||= Togglr.configuration.repositories.map do |repo|
          create_instance_of repo
        end
      end

      def create_instance_of class_name
        class_name.split('::').inject(Object) do |mod, name|
          mod.const_get(name)
        end.new
      end

      register_features
  end
end
