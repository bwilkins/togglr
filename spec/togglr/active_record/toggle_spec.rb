#encoding: utf-8

require_relative '../../spec_helper'
require_relative '../../support/active_record'
require 'togglr/toggles'
require 'togglr/active_record/toggle'

module Togglr
  module ActiveRecord
    describe Toggle do
      describe '.get' do
        let!(:toggle) do
          t = Toggle.new.tap { |t| t.name = 'my_toggle'; t.value = false }
          t.save!
          t
        end

        context 'database entry exists' do
          it 'returns a Toggle object' do
            expect(described_class.get('my_toggle')).to eq toggle
          end
        end

        context 'no database entry exists' do
          it 'returns nil' do
            expect(described_class.get('foobar')).to be_nil
          end
        end
      end

      describe '.set' do
        context 'with no database entry' do
          it 'creates a new database entry with specified value' do
            expect(Toggle.get('foobar')).to be_nil
            t = Toggle.set('foobar', true)
            expect(t).to be_persisted
            expect(t.value).to be_true
            expect(Toggle.get('foobar').value).to be_true
          end
        end

        context 'with existing database entry' do
          let!(:toggle) do
            t = Toggle.new.tap { |t| t.name = 'my_toggle2'; t.value = false }
            t.save!
            t
          end

          it 'returns the existing entry with new value set' do
            expect(Toggle.get('my_toggle2').value).to be_false
            t = Toggle.set('my_toggle2', true)
            expect(t).to be_persisted
            expect(t.value).to be_true
            expect(Toggle.get('my_toggle2').value).to be_true
          end
        end
      end
    end
  end
end
