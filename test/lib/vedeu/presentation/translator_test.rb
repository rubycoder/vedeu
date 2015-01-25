require 'test_helper'

module Vedeu

  describe Translator do

    let(:described) { Translator.new(colour) }
    let(:instance)  { Translator.new(colour) }
    let(:colour)    { '#ff0000' }

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(Translator) }
      it { subject.instance_variable_get('@colour').must_equal(colour) }
    end

  end # Translator

end # Vedeu
