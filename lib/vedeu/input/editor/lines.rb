module Vedeu

  module Editor

    # Manipulate the lines of an Vedeu::Editor::Document.
    #
    class Lines

      # @!attribute [rw] lines
      # @return [String]
      attr_accessor :lines

      # Coerce a document into a new instance of Vedeu::Editor::Lines.
      #
      # @param document [Array<String>|Vedeu::Editor::Lines]
      # @return [Vedeu::Editor::Lines]
      def self.coerce(document)
        return document if document.is_a?(self)

        if document.is_a?(Array)
          new(document)

        else
          new

        end
      end

      # Returns a new instance of Vedeu::Editor::Lines.
      #
      # @param lines [Array<String>|NilClass]
      # @return [Vedeu::Editor::Lines]
      def initialize(lines = nil)
        @lines = lines || []
      end

      # Delete the line from the lines positioned at the given index.
      #
      # @param index [Fixnum|NilClass]
      # @return [String]
      def delete_line(index = nil)
        if lines.empty? || (index && index <= 0)
          lines

        elsif index && index <= size
          @lines = lines.dup.tap { |lines| lines.slice!(index) }

        else
          @lines = lines.dup.tap(&:pop)

        end

        self
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Editor::Lines]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class && lines == other.lines
      end
      alias_method :==, :eql?

      # Insert the line on the line below the given index.
      #
      # @param line [String]
      # @param index [Fixnum|NilClass]
      # @return [String]
      def insert_line(line, index = nil)
        return self unless line

        if index
          if index <= 0
            @lines = lines.insert(0, line)

          elsif index >= size
            @lines = lines << line

          else
            @lines = lines.insert(index, line)

          end
        else
          @lines = lines + [line]

        end

        self
      end

      # Returns the line at the given index.
      #
      # @param index [Fixnum|NilClass]
      # @return [Vedeu::Editor::Line]
      def line(index = nil)
        return Vedeu::Editor::Line.new             unless lines
        return Vedeu::Editor::Line.new(lines.last) unless index

        if index <= 0
          Vedeu::Editor::Line.new(lines.first)

        elsif index && index <= size
          Vedeu::Editor::Line.new(lines[index])

        else
          Vedeu::Editor::Line.new(lines.last)

        end
      end

      # Return the number of lines.
      #
      # @return [Fixnum]
      def size
        lines.size
      end

    end # Line

  end # Editor

end # Vedeu
