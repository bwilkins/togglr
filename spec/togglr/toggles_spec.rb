# encoding: utf-8

require_relative '../spec_helper'
require 'togglr/toggles'
require 'togglr/base_repository'

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
      Tempfile.new('yaml_repo').tap do |file|
        file.write(file_contents)
        file.rewind
      end
    end

    after do
      temp_file.close
      temp_file.unlink
    end

    after do
      Toggles.instance.toggles.clear
    end

    before do
      Togglr.configure do |cfg|
        cfg.toggles_file = temp_file.path
      end
      Toggles.register_toggles
    end

    describe 'public interface' do
      it 'has a predicate getter and value setter for each toggle configured' do
        expect(Toggles).to respond_to(:true_toggle?)
        expect(Toggles).to respond_to(:false_toggle?)
        expect(Toggles).to respond_to(:some_toggle?)
        expect(Toggles).to respond_to(:true_toggle=)
        expect(Toggles).to respond_to(:false_toggle=)
        expect(Toggles).to respond_to(:some_toggle=)
        expect(Toggles).to respond_to(:each)
      end
    end

    context 'with only default YAML repository' do
      it 'returns configured toggles state' do
        expect(Toggles.true_toggle?).to be_true
        expect(Toggles.false_toggle?).to be_false
      end

      describe '#each' do
        it 'executes a block for each toggle configured' do
          my_number = 0
          Toggles.each {|t| my_number +=1 }
          expect(my_number).to eq(Toggles.instance.toggles.count)
        end
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

