require 'test_helper'

module Vedeu

  module Logging

    module Debug

      describe IPS do

        let(:described) { Vedeu::Logging::Debug::IPS }
        let(:instance)  { described.new }

        describe '#initialize' do
          it { instance.must_be_instance_of(described) }
          it { instance.instance_variable_get('@old_stdout').must_be_instance_of(StringIO) }
          it { instance.instance_variable_get('@samples').must_equal({}) }
          it { instance.instance_variable_get('@benchmark').must_be_instance_of(Benchmark::IPS::Job) }
          it { instance.instance_variable_get('@count').must_equal(0) }
        end

        describe 'accessors' do
          it { instance.must_respond_to(:samples) }
          it { instance.must_respond_to(:samples=) }
          it { instance.must_respond_to(:benchmark) }
          it { instance.must_respond_to(:benchmark=) }
        end

        describe '#add_item' do
          # @todo Add more tests.
        end

        describe '#execute!' do
          # @todo Add more tests.
        end

      end # IPS

    end # Debug

  end # Logging

end # Vedeu
