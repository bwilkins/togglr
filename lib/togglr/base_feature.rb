#encoding: utf-8

module Togglr
  class BaseFeature
    def initialize(name, default_value, repositories)
      @name = name
      @default_value = default_value
      @repositories = repositories
    end

    def active?
      default = Proc.new do
        default_value
      end
      repositories.reverse.inject(default) do |chained, repository|
        Proc.new { repository.read_or_delegate(name, &chained) }
      end.call
    end

    def active=(new_state)
      repositories.each do |repository|
        repository.write(name, new_value)
      end
    end

    private
      attr_accessor :default_value
  end
end