#encoding: utf-8

module Togglr
  class BaseRepository
    def read(name)
      raise NotImplementedError
    end

    def write(name, value)
      raise NotImplementedError
    end

    def store(name)
      read(name) || write(name, yield)
    end
  end
end
