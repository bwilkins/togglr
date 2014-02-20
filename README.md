Togglr
======

GEM for feature toggling

## Setup

Add
```
gem 'togglr', git: 'git@github.com:hooroo/togglr.git'
```
to your Gemfile

## Config

```
require 'togglr'
require 'togglr/toggles'

Togglr.configure do |config|
  config.toggles_file = File.expand_path(File.join(Rails.root, 'config', 'togglr.yml'))
  config.repositories = ['Repositories::ToggleRepository']
end

Togglr::Toggles.register_toggles
```

By default the config file is supposed to be in config directory, named togglr.yml

Use the repositories configuration to decide which repositories you want. List as array of comma separated class name strings.

### Toggles File Format
```
---
:category_name:
  :toggle_1:
    :value: true / false
    :other_property: true / false
  :toggle_2:
    :value true / false

  ...
```
```