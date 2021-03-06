# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Events

    describe Trigger do

      let(:described)  { Vedeu::Events::Trigger }
      let(:instance)   { described.new(event_name, args) }
      let(:event_name) { :_testing_event_ }
      let(:args)       {}

      describe '.trigger' do
        before { Vedeu.bind(event_name) { :_only_one_result_ } }

        subject { described.trigger(event_name) }

        it { subject.must_equal(:_only_one_result_) }
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(event_name) }
        it { instance.instance_variable_get('@args').must_equal([args]) }
        it do
          instance.instance_variable_get('@repository').must_equal(Vedeu.events)
        end
      end

      describe '#trigger' do
        subject { instance.trigger }

        context 'when only one result occurs from triggering the event' do
          let(:event_name) { :_one_result_ }

          before { Vedeu.bind(event_name) { :_only_one_result_ } }

          it { subject.must_equal(:_only_one_result_) }
        end

        context 'when multiple results occur from triggering an event' do
          let(:event_name) { :_multiple_results_ }

          before {
            Vedeu::Events::Event.register(event_name) { :_result_one_ }
            Vedeu::Events::Event.register(event_name) { :_result_two_ }
          }

          it { subject.must_equal([:_result_one_, :_result_two_]) }
        end

        context 'when the event has not been registered' do
          let(:event_name) { :_not_found_ }

          it { subject.must_equal([]) }
        end
      end

    end # Trigger

  end # Events

end # Vedeu
