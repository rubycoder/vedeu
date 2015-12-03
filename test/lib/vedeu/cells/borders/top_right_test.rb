require 'test_helper'

module Vedeu

  module Cells

    describe TopRight do

      let(:described) { Vedeu::Cells::TopRight }
      let(:instance)  { described.new }

      describe '#type' do
        subject { instance.type }

        it { subject.must_equal(:top_right) }
      end

    end # TopRight

  end # Cells

end # Vedeu
