# frozen_string_literal: true

require 'vedeu/dsl/all'

module Vedeu

  module Views

    # Represents a container for {Vedeu::Views::Line} and
    # {Vedeu::Views::Stream} objects.
    #
    class View

      # Provides DSL methods for Vedeu::Views::View objects.
      #
      # @api public
      #
      class DSL

        include Vedeu::DSL
        include Vedeu::DSL::Border
        include Vedeu::DSL::Cursors
        include Vedeu::DSL::Elements
        include Vedeu::DSL::Geometry
        include Vedeu::DSL::Use

      end # DSL

      extend Forwardable
      include Vedeu::Repositories::Model
      include Vedeu::Presentation
      include Vedeu::Views::Value

      collection Vedeu::Views::Lines
      deputy     Vedeu::Views::View::DSL
      entity     Vedeu::Views::Line

      def_delegators :value,
                     :lines

      alias lines= value=
      alias lines? value?

      # @!attribute [rw] cursor_visible
      # @return [Boolean]
      attr_accessor :cursor_visible
      alias cursor_visible? cursor_visible

      # @!attribute [rw] name
      # @macro return_name
      attr_accessor :name

      # @!attribute [rw] wordwrap
      # @return [Boolean]
      attr_accessor :wordwrap
      alias wordwrap? wordwrap

      # @!attribute [rw] zindex
      # @return [Fixnum]
      attr_accessor :zindex

      # Return a new instance of Vedeu::Views::View.
      #
      # @param attributes [Hash]
      # @option attributes client [Vedeu::Client]
      # @option attributes colour [Vedeu::Colours::Colour]
      # @option attributes cursor_visible [Boolean]
      # @option attributes value [Vedeu::Views::Lines]
      # @option attributes name [String|Symbol]
      # @option attributes parent [Vedeu::Views::Composition]
      # @option attributes style [Vedeu::Presentation::Style]
      # @option attributes wordwrap [Boolean]
      # @option attributes zindex [Fixnum]
      # @return [Vedeu::Views::View]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # Adds the child to the collection.
      #
      # @param child [Vedeu::Views::Line]
      # @return [Vedeu::Views::Lines]
      def add(child)
        @value = value.add(child)
      end
      alias << add

      # @return [Hash]
      def attributes
        {
          client:         client,
          colour:         colour,
          cursor_visible: cursor_visible,
          name:           name,
          parent:         parent,
          style:          style,
          value:          value,
          wordwrap:       wordwrap,
          zindex:         zindex,
        }
      end

      # @return [NilClass|String|Symbol]
      def name
        if present?(@name)
          @name

        elsif parent && present?(parent.name)
          parent.name

        end
      end

      # @return [NilClass|void]
      def parent
        present?(@parent) ? @parent : nil
      end

      # Store the view in its respective buffer.
      #
      # @param refresh [Boolean] Should the buffer of the view be
      #   refreshed once stored? Default: false.
      # @macro raise_missing_required
      # @return [Vedeu::Views::View]
      def update_buffer(refresh = false)
        if present?(name)
          buffer.add(self, refresh)

        else
          raise Vedeu::Error::MissingRequired,
                'Cannot store a view without a name.'

        end

        self
      end

      # Returns a boolean indicating whether the view is visible.
      #
      # @return [Boolean]
      def visible?
        interface.visible?
      end

      private

      # @return [Vedeu::Buffers::Buffer]
      def buffer
        Vedeu.buffers.by_name(name)
      end

      # @macro defaults_method
      def defaults
        {
          client:         nil,
          colour:         Vedeu.config.colour,
          cursor_visible: true,
          name:           nil,
          parent:         nil,
          style:          :normal,
          value:          [],
          wordwrap:       true,
          zindex:         0,
        }
      end

      # @return [Vedeu::Interfaces::Interface]
      def interface
        Vedeu.interfaces.by_name(name)
      end

    end # View

  end # Views

end # Vedeu
