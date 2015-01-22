require 'togglr'
require 'togglr/toggles'

Togglr.configure do |config|
  config.toggles_file = File.expand_path(File.join(Rails.root, 'config', 'togglr.yml'))
  config.repositories = []
end

Togglr::Toggles.register_toggles
