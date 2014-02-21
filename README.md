Togglr
======

GEM for feature toggling

## Setup

1. Add `gem 'togglr', git: 'git@github.com:hooroo/togglr.git'` to your Gemfile
1. Run `bundle install`
1. Run `bundle exec rails generate togglr:install` to generate a default initialiser and toggles yml file

## ActiveRecord Repository
In order to use the ActiveRecord Repository (in a rails 3/4 app - obviously)

1. run the generator to generate migration which will create the table for persisting toggles' state: `bundle exec rails generate togglr:active_record`
1. inspect the generated migration (in `db/migrate/???_create_togglr_toggles.rb`) and run: `bundle exec rake db:migrate`
1. Add to the repositories list in the initialiser: `config.repositories = ['Togglr::ActiveRecord::Repository']`


## Config

```
require 'togglr'
require 'togglr/toggles'

Togglr.configure do |config|
  config.toggles_file = File.expand_path(File.join(Rails.root, 'config', 'togglr.yml'))
  config.repositories = []
end

Togglr::Toggles.register_toggles
```

By default the config file is supposed to be in config directory, named togglr.yml

You can add these basic config files with `rails generate togglr:install`

Make sure each toggle has a UNIQUE name. Duplicate toggles are disallowed. The last toggle with the same name wins - irrespective of its category.

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

## Usage
To check for a toggle state use the toggle name predicate, eg: `Togglr::Toggles.feature?` 


## BYO
You can use your own repository implementation as long as it responds to the following messages:
```
read(toggle_name) : bool
write(toggle_name, toggle_value) : bool
```

## TODOs

- add redis repository
- add request store repository
