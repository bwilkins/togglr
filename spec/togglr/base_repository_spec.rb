#encoding: utf-8

require_relative '../spec_helper'
require 'togglr/base_repository'

module Togglr
  describe BaseRepository do

    it 'responds to :read' do
      expect(subject).to respond_to(:read)
    end

    it 'responds to :write' do
      expect(subject).to respond_to(:write)
    end

    it 'responds to :read_or_delegate' do
      expect(subject).to respond_to(:read_or_delegate)
    end
  end
end
