#encoding: utf-8

module Togglr
  class Feature

    def self.register_features
      authorative_repository.features.each do |feature|
        register_feature(feature)
      end
    end

    def self.register_feature(feature)
      f = SimpleFeature.new(feature[:name], feature[:default_state])
      define_method("#{feature}?") do
        f.active?
      end

      define_method("#{feature}=") do |new_value|
        f.state = new_value
      end
    end

    def authorative_repository
      Togglr.configuration.authorative_repository.split('::').inject(Object) do |mod, name|
        mod.const_get(name)
      end.new
    end
  end
end
