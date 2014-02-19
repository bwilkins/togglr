#encoding: utf-8

require_relative '../spec_helper'

require 'togglr/yaml_repository'

module Togglr
  describe YamlRepository do

    let(:file_contents) {
      %Q{---
:true_feature: true
:false_feature: false}
    }

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
    let(:repo) {YamlRepository.new(filename)}

    it 'is not null' do
      expect(repo).to_not be_nil
    end

    it 'returns state of feature' do
      expect(repo.read(:true_feature)).to be_true
      expect(repo.read(:false_feature)).to be_false
    end

    it 'does nothing on write' do
      repo.write(:true_feature, false)
      expect(repo.read(:true_feature)).to_not be_false
    end
  end
end