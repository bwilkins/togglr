require 'rack/test'

module Togglr
  class RackAPI
    def call(env)
      toggles = {}
      [200, {}, toggles.to_json]
    end
  end
end
