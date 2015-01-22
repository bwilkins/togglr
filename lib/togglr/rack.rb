require 'json'

module Togglr
  class RackAPI
    def call(env)
      toggles = Togglr::Toggles.instance.toggles.inject({}) do |toggles, toggle|
        toggles[toggle.name] = { value: toggle.active? }
        toggles
      end

      body = toggles.to_json
      [200, { 'Content-Type' => 'text/javascript', 'Content-Length' => body.length.to_s}, [body]]
    end
  end
end
