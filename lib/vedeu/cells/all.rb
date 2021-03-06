# frozen_string_literal: true

module Vedeu

  # Each available character space in the visible terminal is
  # represented in Vedeu as a cell of some type. Each type of cell
  # has specific behaviour when handled (including being rendered) by
  # Vedeu.
  #
  # @api private
  #
  module Cells

  end # Cells

end # Vedeu

require 'vedeu/cells/support/all'
require 'vedeu/cells/empty'
require 'vedeu/cells/border'
require 'vedeu/cells/borders/all'
require 'vedeu/cells/char'
require 'vedeu/cells/clear'
require 'vedeu/cells/cursor'
require 'vedeu/cells/escape'
