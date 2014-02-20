#encoding: utf-8

require_relative '../spec_helper'
require 'togglr/toggles'

module Togglr
  describe Toggles do

    let(:file_contents) do
      %q{---
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

    context 'with only default YAML repository' do
      before do
        Togglr.configure do |cfg|
          cfg.toggles_file = temp_file.path
        end
        Toggles.register_toggles
      end

      it 'returns configured toggles state' do
        expect(Toggles.true_toggle?).to be_true
        expect(Toggles.false_toggle?).to be_false
      end
    end

    context 'with other repositories' do
      before do
        Togglr.configure do |cfg|
          cfg.toggles_file = temp_file.path
          cfg.repositories = ['Togglr::TestRepository1', 'Togglr::TestRepository2']
        end
        Toggles.register_toggles
      end

      it 'returns toggle state as stored by repository' do
        expect(Toggles.true_toggle?).to be_false
        expect(Toggles.false_toggle?).to be_true
      end

    end # context 'with other repositories'

  end # describe Toggles

  class TestRepository1 < BaseRepository
    def initialize
      @toggles = {}
    end

    def read(name)
      toggles[name]
    end

    def write(name, new_value)
      toggles[name] = new_value
    end

    private
    attr_accessor :toggles
  end

  class TestRepository2 < TestRepository1
    def write(name, value)
      super(name, !value)
    end
  end


end # module Togglr

