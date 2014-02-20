#encoding: utf-8

require 'rails/generators'

module Togglr
  class ActiveRecordGenerator < Rails::Generators::Base

    desc "This generator creates a migration for persisting feature toggles via Active Record"
    def generate_migration
      generate('migration','CreateTogglrToggles name:string value:boolean timestamps')
    end
  end
end
