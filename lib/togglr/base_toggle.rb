module Togglr
  class BaseToggle
    attr_reader :name, :description

    def initialize(name, properties, repositories)
      @name = name

      if properties.is_a? Hash
        @default_value = properties[:value] || false
        @description = properties[:description] || "#{name} toggle"
      else
        @default_value = properties
      end

      @repositories = repositories
    end

    def active?
      default = Proc.new do
        default_value
      end
      repositories.reverse.inject(default) do |chained, repository|
        Proc.new do
          repository.read_or_delegate(name, &chained)
        end
      end.call
    end

    def active=(new_state)
      Togglr.log("Toggle #{name} was switched #{new_state ? 'on' : 'off'} togglr_toggle_changed=#{name} #{new_state}=#{Time.now}")
      repositories.each do |repository|
        repository.write(name, new_state)
      end
    end

    private
      attr_reader :default_value, :repositories
  end
end
