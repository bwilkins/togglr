module Togglr
  class BaseRepository

    def read(name)
      raise NotImplementedError
    end

    def write(name, value)
      raise NotImplementedError
    end

    def read_or_delegate(name)
      value = read(name)
      value = write(name, yield) if value.nil?
      value
    end
  end
end
