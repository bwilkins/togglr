#encoding: utf-8

require_relative '../spec_helper'
require 'togglr/toggles'

module Togglr
  describe Toggles do

    let(:file_contents) do
      %q{---
:true_feature:
  :value: true
:false_feature:
  :value: false
:some_feature:
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
          cfg.features_file = temp_file.path
        end
        Toggles.register_features
      end

      it 'returns configured features state' do
        expect(Toggles.true_feature?).to be_true
        expect(Toggles.false_feature?).to be_false
      end
    end

    context 'with other repositories' do
      before do
        Togglr.configure do |cfg|
          cfg.features_file = temp_file.path
          cfg.repositories = ['Togglr::TestRepository1', 'Togglr::TestRepository2']
        end
        Toggles.register_features
      end

      it 'returns feature state as stored by repository' do
        expect(Toggles.true_feature?).to be_false
        expect(Toggles.false_feature?).to be_true
      end

    end # context 'with other repositories'

  end # describe Toggles

  class TestRepository1 < BaseRepository
    def initialize
      @features = {}
    end

    def read(name)
      features[name]
    end

    def write(name, new_value)
      features[name] = new_value
    end

    private
    attr_accessor :features
  end

  class TestRepository2 < TestRepository1
    def write(name, value)
      super(name, !value)
    end
  end


end # module Togglr

