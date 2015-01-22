require_relative '../../support/active_record'
require 'togglr/toggles'
require 'togglr/active_record/repository'

module Togglr
  module ActiveRecord
    describe Repository do
      describe '#read' do
        context 'with no existing entry in repository' do
          it 'returns nil' do
            expect(described_class.new.read('foobar')).to be_nil
          end
        end

        context 'with an existing entry in repository' do
          it 'returns the corresponding value from the repository' do
            Toggle.new.tap{|t| t.name = 'foobar'; t.value = true}.save!

            expect(described_class.new.read('foobar')).to be(true)
          end
        end
      end

      describe '#write' do
        it 'returns the value written to repository' do
          expect(described_class.new.write('foobar', true)).to be(true)
          expect(described_class.new.write('foobar', false)).to be(false)
        end
      end
    end
  end
end
