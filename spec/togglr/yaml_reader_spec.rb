#encoding: utf-8

require_relative '../spec_helper'

require 'togglr/yaml_reader'

module Togglr
  describe YamlReader do

    let(:file_contents) do
      %q{---
:true_toggle:
  :value: true
:false_toggle:
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

    let(:filename) {temp_file.path}
    let(:repo) {YamlReader.new(filename)}

    it 'is not null' do
      expect(repo).to_not be_nil
    end

    it 'returns toggles with initial state' do
      expect(repo.toggles).to eq({true_toggle: {value: true}, false_toggle: {value: false}})
    end

  end
end