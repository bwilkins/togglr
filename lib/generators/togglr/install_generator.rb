#encoding: utf-8

require 'rails/generators'

module Togglr
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('./templates', File.dirname(__FILE__))

    desc "This generator creates an intializer for Togglr"
    def generate_initializer
      template('initializer.rb', 'config/initializers/togglr.rb')
      template('togglr.yml', 'config/togglr.yml')
    end
  end
end
