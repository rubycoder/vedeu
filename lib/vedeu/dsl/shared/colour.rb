module Vedeu

  module DSL

    # Provides colour helpers for use in the {Vedeu::DSL::Interface},
    # {Vedeu::DSL::Line} and {Vedeu::DSL::Stream} classes.
    #
    # @api public
    #
    module Colour

      # Define the background colour for an interface, line, or a stream. When
      # called with a block, will create a new stream with the background colour
      # specified. When the block terminates, the background will return to that
      # of the parent.
      #
      # @note The last defined background colour for a particular interface,
      #   line or stream overrides previously defined entries in the same block.
      #
      # @param value [String] A HTML/CSS value.
      #
      # @example
      #   interface 'my_interface' do
      #     background '#0022ff' # /or/ (blue)
      #     bgcolor    '#22ff00' # /or/ (blue is overridden to green)
      #     bg         '#ff0022' #      (green is overridden to red)
      #     # ...
      #
      #     lines do
      #       background '#2200ff'
      #       # ...
      #
      #       stream do
      #         background '#22ff00'
      #         # ...
      #
      # @return [String]
      def background(value = '')
        colour(background: value)
      end
      alias_method :bg,      :background
      alias_method :bgcolor, :background

      # @see Vedeu::DSL::Colour#background
      def foreground(value = '')
        colour(foreground: value)
      end
      alias_method :fg,      :foreground
      alias_method :fgcolor, :foreground

      # Define either or both foreground and background colours for an
      # interface, line or a stream. At least one attribute is required.
      #
      # @note Rejects invalid keys and empty/nil attributes. Also, the last
      #   defined colour for a particular interface, line or stream overrides
      #   previously defined entries in the same block.
      #
      # @param attributes [Hash] See {Vedeu::Colour}
      #
      # @example
      #   interface 'my_interface' do
      #     colour background: '#ff00ff', foreground: '#ffff00'
      #     # ...
      #
      #     lines do
      #       colour background: '#000000', foreground: '#ffffff'
      #       # ...
      #
      #       stream do
      #         colour background: '#000000', foreground: '#ffffff'
      #         # ...
      #
      # @return [Hash]
      def colour(attributes = {})
        attributes.delete_if do |k, v|
          [:background, :foreground].include?(k) == false || v.nil? || v.empty?
        end

        model.colour = Vedeu::Colour.new(attributes)
      end

    end # Colour

  end # DSL

end # Vedeu
