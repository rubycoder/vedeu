# frozen_string_literal: true

module Vedeu

  module Cells

    # Provides the character/escape sequence to draw one cell of a
    # horizontal border with a custom value, colour and style.
    #
    # @api private
    #
    class Horizontal < Vedeu::Cells::Border

      # @return [String]
      def as_html
        '&#x2500;'
      end

      # @return [String]
      def text
        '-'
      end

      # @return [Symbol]
      def type
        :horizontal
      end

      private

      # @macro defaults_method
      def defaults
        super.merge!(value: Vedeu.esc.horizontal)
      end

    end # Horizontal

  end # Cells

end # Vedeu
