require 'test_helper'

module Vedeu

  describe FileRenderer do

    let(:described) { Vedeu::FileRenderer }
    let(:instance)  { described.new(output, options) }
    let(:output)    {}
    let(:options)   {
      {
        timestamp: timestamp
      }
    }
    let(:timestamp) { true }

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::FileRenderer) }
      it { instance.instance_variable_get('@output').must_equal(output) }
      it { instance.instance_variable_get('@options').must_equal(options) }
    end

    describe '.render' do
      let(:_time) { Time.new(2015, 4, 12, 20, 05) }

      before do
        Time.stubs(:now).returns(_time)
        File.stubs(:open)
      end

      subject { described.render(output, options) }

      it { subject.must_be_instance_of(String) }

      context 'when the timestamp option is true' do
        it { File.expects(:open).with('/tmp/out_1428865500.0', 'w'); subject }
      end

      context 'when the timestamp option is false' do
        let(:timestamp) { false }

        it { File.expects(:open).with('/tmp/out', 'w'); subject }
      end
    end

  end # FileRenderer

end # Vedeu
