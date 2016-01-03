# frozen_string_literal: true

module Vedeu

  module Renderers

    # Writes the given output to a file.
    #
    class File

      include Vedeu::Renderers::Options

      # @return [String]
      def clear
        render('')
      end

      # Render the output (either content or clearing) to a file.
      #
      # @return [String]
      def write
        data = content

        ::File.write(filename, data)

        data
      end

      private

      # @return [String]
      def content
        output
      end

      # @return [Boolean]
      def write_file?
        true
      end

    end # File

  end # Renderers

end # Vedeu
