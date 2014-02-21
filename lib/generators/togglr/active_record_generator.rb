#encoding: utf-8

require 'rails/generators'
require 'rails/generators/active_record'

module Togglr
  class ActiveRecordGenerator < ::ActiveRecord::Generators::Base
    # Inspired by the friendly_id gem. Since ActiveRecord::Generators::Base inherits from Rails::Generators::NamedBase,
    # this class requires a NAME parameter. We always use 'togglr_toggles', so we set a random name as the default here.
    argument :name, type: :string, default: 'random_name'

    source_root File.expand_path('./templates', File.dirname(__FILE__))

    desc "This generator creates a migration for persisting feature toggles via Active Record"
    def generate_migration
      migration_template('migration.rb', 'db/migrate/create_togglr_toggles.rb')
    end
  end
end
