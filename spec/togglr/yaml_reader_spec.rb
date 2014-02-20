#encoding: utf-8

require_relative '../spec_helper'

require 'togglr/yaml_reader'

module Togglr
  describe YamlReader do

    let(:file_contents) do
      %q{---
:category:
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
    let(:yaml_reader) {YamlReader.new(filename)}

    it 'is not null' do
      expect(yaml_reader).to_not be_nil
    end

    describe '#toggles' do

      it 'returns toggles with initial state' do
        expect(yaml_reader.toggles).to eq({true_toggle: {value: true, category: :category}, false_toggle: {value: false, category: :category}})
      end

      it 'returns a hash' do
        expect(yaml_reader.toggles).to be_a(Hash)
      end

      context 'with many categories' do
        let(:file_contents) do
          %q{---
:category1:
  :true_toggle:
    :value: true
:category2:
  :false_toggle:
    :value: false
:category3:
  :some_toggle:
    :value: true
}
        end


        it 'still returns a hash' do
          expect(yaml_reader.toggles).to be_a(Hash)
        end

        it 'it has as many key-value pairs as there are toggles defined' do
          expect(yaml_reader.toggles.length).to eq 3
        end

        it 'contains only the toggles defined under our categories' do
          expect(yaml_reader.toggles.keys).to include(:true_toggle, :false_toggle, :some_toggle)
          expect(yaml_reader.toggles.keys).to_not include(:true_togglex)
        end

        it 'adds the correct category onto each individual toggle' do
          yaml_reader.categorised_toggles.each do |category, toggles|
            toggles.keys.each do |toggle_name|
              expect(yaml_reader.toggles[toggle_name][:category]).to eq(category)
            end
          end
        end
      end
    end

  end
end