#encoding: utf-8

require_relative '../spec_helper'
require_relative '../support/active_record'
require 'togglr/toggles'
require 'togglr/active_record/repository'

module Togglr
  describe Toggles do

    let(:file_contents) do
      %q{---
:category:
  :true_toggle:
    :value: true
  :false_toggle:
    :value: false
  :some_toggle:
    :value: false
      }
    end

    let(:temp_file) do
      t = Tempfile.new('yaml_repo')
      t.write(file_contents)
      t.rewind
      t
    end

    after do
      temp_file.close
      temp_file.unlink
    end

    context 'with the ActiveRecord repository' do
      before do
        Togglr.configure do |cfg|
          cfg.toggles_file = temp_file.path
          cfg.repositories = ['Togglr::ActiveRecord::Repository']
        end

        Toggles.register_toggles
      end


      describe '#<toggle_name>?' do
        context 'no value in database' do
          it 'returns the toggle value from the yaml file' do
            expect(Togglr::Toggles.true_toggle?).to be_true
          end
        end

        context 'value in the database' do
          it 'returns the value from the database' do
            Togglr::Toggles.true_toggle = false
            expect(Togglr::Toggles.true_toggle?).to be_false
          end
        end
      end
    end
  end


end # module Togglr

