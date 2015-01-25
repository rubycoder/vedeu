require 'test_helper'

module Vedeu

  describe Validator do

    let(:described)  { Validator.new(attributes) }
    let(:attributes) { {} }

    describe '#initialize' do
      it { described.must_be_instance_of(Validator) }
      it { described.instance_variable_get('@attributes').must_equal(attributes) }
    end

    describe '.check' do
      it { proc { Validator.check(attributes) }.must_raise(InvalidSyntax) }
    end

  end # Validator

end # Vedeu
