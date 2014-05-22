require_relative '../../../test_helper'

module Vedeu
  describe Compositor do
    let(:described_class) { Compositor }
    let(:instance) { described_class.new(rows) }
    let(:rows)     { [[]] }

    before { Terminal.stubs(:output) }

    it { instance.must_be_instance_of(Compositor) }

    describe '.write' do
      subject { described_class.write(rows) }

      it { subject.must_be_instance_of(String) }

      context 'when empty' do
        let(:rows) { [] }

        it { subject.must_be_instance_of(NilClass) }
      end

      context 'when unstyled' do
        context 'and a single line' do
          let(:rows) { [['Some text...']] }

          it { subject.must_equal('Some text...') }
        end

        context 'and multi-line' do
          let(:rows) {
            [
              ['Some text...'],
              ['Some more text...']
            ]
          }

          it { subject.must_equal("Some text...\nSome more text...") }
        end
      end

      context 'when styled' do
        context 'with colour pair' do
          context 'and a single line' do
            let(:rows) {
              [
                [[:red, :white], 'Some text...']
              ]
            }

            it { subject.must_equal("\e[38;5;31m\e[48;5;47mSome text...") }
          end

          context 'and multi-line' do
            let(:rows) {
              [
                [[:red, :white],   'Some text...'],
                [[:blue, :yellow], 'Some more text...']
              ]
            }

            it { subject.must_equal("\e[38;5;31m\e[48;5;47mSome text...\n" \
                                    "\e[38;5;34m\e[48;5;43mSome more text...") }
          end
        end

        context 'with a style' do
          context 'and a single line' do
            let(:rows) {
              [
                [:bold, 'Some text...']
              ]
            }

            it { subject.must_equal("\e[1mSome text...") }
          end

          context 'and multi-line' do
            let(:rows) {
              [
                [:inverse,   'Some text...'],
                [:underline, 'Some more text...']
              ]
            }

            it { subject.must_equal("\e[7mSome text...\n" \
                                    "\e[4mSome more text...") }
          end
        end

        context 'with an unknown style' do
          let(:rows) {
            [
              [:unknown, 'Some text...']
            ]
          }

          it 'renders in the default style' do
            subject.must_equal("Some text...")
          end
        end
      end
    end
  end
end