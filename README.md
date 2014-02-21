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

Make sure each toggle has a unique name. Duplicate toggles are disallowed.

Use the repositories configuration to decide which repositories you want. List as array of comma separated class name strings.

### Toggles File Format
```yaml
---
:category_name:
  :toggle_1:
    :value: true / false
    :other_property: true / false
  :toggle_2:
    :value true / false

  ...
```

## Rails Repository
In order to use the ActiveRecord Repository (in a rails 3/4 app - obviously)

- configure the repositories to use:
```rb
config.repositories = ['Togglr::ActiveRecord::Repository']
```
- run the generator to generate migration which will create the table for persisting toggles' state:
```sh
rails generate togglr:active_record
```
- inspect the generated migration (in db/migrate/???_create_togglr_toggles.rb) and run it
```rake
rake db:migrate
```