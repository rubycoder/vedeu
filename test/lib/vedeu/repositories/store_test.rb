# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Repositories

    class StoreTestClass
      include Vedeu::Repositories::Store

      attr_reader :model

      def initialize(model = nil, storage = {})
        @model   = model
        @storage = storage
      end

      private

      def in_memory
        {}
      end
    end

    describe Store do

      let(:described)          { Vedeu::Repositories::Store }
      let(:included_described) { Vedeu::Repositories::StoreTestClass }
      let(:included_instance)  { included_described.new(model, storage) }
      let(:model)              {}
      let(:storage)            {}

      describe '#all' do
        it { included_instance.must_respond_to(:all) }
      end

      describe '#clear' do
        it { included_instance.must_respond_to(:clear) }
      end

      describe '#each' do
        subject { included_instance.each }

        it { subject.must_be_instance_of(Enumerator) }
      end

      describe '#empty?' do
        subject { included_instance.empty? }

        context 'when empty' do
          it { subject.must_equal(true) }
        end

        context 'when not empty' do
          let(:storage) { [:item] }

          it { subject.must_equal(false) }
        end
      end

      describe '#exists?' do
        let(:_name) {}

        subject { included_instance.exists?(_name) }

        context 'when the store is empty' do
          let(:_name) { :vedeu_repositories_store }

          it { subject.must_equal(false) }
        end

        context 'with no name' do
          it { subject.must_equal(false) }
        end

        context 'with empty name' do
          let(:_name) { '' }

          it { subject.must_equal(false) }
        end

        context 'when the model does not exist' do
          let(:storage) { { 'samarium' => [:some_model_data] } }
          let(:_name)   { 'terbium' }

          it { subject.must_equal(false) }
        end

        context 'when the model exists' do
          let(:storage) { { 'samarium' => [:some_model_data] } }
          let(:_name)   { 'samarium' }

          it { subject.must_equal(true) }
        end
      end

      describe '#registered?' do
        it { included_instance.must_respond_to(:registered?) }
      end

      describe '#registered' do
        subject { included_instance.registered }

        it { subject.must_be_instance_of(Array) }

        context 'when the storage is a Hash' do
          let(:storage) {
            {
              'rutherfordium' => { name: 'rutherfordium' }
            }
          }

          it 'returns a collection of the names of all the registered entities' do
            subject.must_equal(['rutherfordium'])
          end
        end

        context 'when the storage is an Array' do
          let(:storage) { ['rutherfordium'] }

          it 'returns the registered entities' do
            subject.must_equal(['rutherfordium'])
          end
        end

        context 'when the storage is a Set' do
          let(:storage) { Set['rutherfordium'] }

          it 'returns the registered entities' do
            subject.must_equal(['rutherfordium'])
          end
        end

        context 'when the storage is empty' do
          it 'returns an empty collection' do
            subject.must_equal([])
          end
        end
      end

      describe '#size' do
        subject { included_instance.size }

        context 'when empty' do
          it { subject.must_equal(0) }
        end

        context 'when not empty' do
          let(:storage) { [:item] }

          it { subject.must_equal(1) }
        end
      end

      describe '#all' do
        it { included_instance.must_respond_to(:all) }
      end

    end # Store

  end # Repositories

end # Vedeu
