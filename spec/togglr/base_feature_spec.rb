#encoding: utf-8

require_relative '../spec_helper'
require 'togglr/base_feature'
require 'togglr/base_repository'

module Togglr
  describe BaseFeature do

    let(:repositories) { [] }
    let(:feature_name) { :test_feature }
    let(:feature_value) { true }
    let(:feature) { BaseFeature.new(feature_name, feature_value, repositories) }



    describe '#active?' do
      context 'without any repositories' do
        it 'returns the default value' do
          expect(feature.active?).to eq feature_value
        end
      end

      context 'with multiple repositories' do
        let(:repositories) { [test_repo1, test_repo2] }
        let(:test_repo_class_1) do
          Class.new(BaseRepository) do
            attr_accessor :features

            def initialize
              @features = {}
            end

            def read(name)
              @features[name]
            end

            def write(name, value)
              @features[name] = value
            end
          end
        end
        let(:test_repo1) { test_repo_class_1.new }

        let(:test_repo_class_2) { Class.new(test_repo_class_1) }
        let(:test_repo2) { test_repo_class_2.new }

        context 'with feature state set in top-level repository' do
          let(:feature_value) { false }
          it 'fetches the value from the top-level repository' do
            test_repo1.features[feature_name] = feature_value
            test_repo2.features[feature_name] = !feature_value

            expect(feature.active?).to eq feature_value
          end

          it 'ignores any values from deeper repositories' do
            test_repo1.features[feature_name] = feature_value
            test_repo2.features[feature_name] = !feature_value
            test_repo2.should_not_receive(:read_or_delegate)

            expect(feature.active?).to eq feature_value
          end
        end

        context 'with feature state not in top-level repository' do
          let(:repo2_feature_value) { !feature_value }
          it 'delegates to a lower-level repository' do
            test_repo1.features.delete(feature_name)
            test_repo2.features[feature_name] = repo2_feature_value

            expect(feature.active?).to eq repo2_feature_value
          end
        end

        context 'with no feature states in any repository' do
          # let(:feature_value) { false }
          it 'returns the default value' do
            test_repo1.features.delete(feature_name)
            test_repo2.features.delete(feature_name)

            expect(feature.active?).to eq feature_value
          end
        end
      end

    end

  end
end