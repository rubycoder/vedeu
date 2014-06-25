[![Code Climate](https://codeclimate.com/github/gavinlaking/vedeu.png)](https://codeclimate.com/github/gavinlaking/vedeu)

# Vedeu

Vedeu is my attempt at creating a terminal based application framework without the need for Ncurses. I've tried to make Vedeu as simple and flexible as possible.


## Installation

Add this line to your application's Gemfile:

    gem 'vedeu'

And then execute:

    $ bundle

## Usage

Expect proper documentation soon!

### Getting Started

    require 'vedeu'

    class MyApp
      include Vedeu

      interface :main, { }

      command   :exit, { entity:   SomeClass,
                         keypress: 'q',
                         keyword:  'quit' }
    end

### On Defining Interfaces

    interface :main, { y:          1,
                       x:          1,
                       width:      auto, # will set to terminal width
                       height:     10,   # also accepts :auto
                       foreground: :white,
                       background: :black,
                       cursor:     false,
                       layer:      0 }

Referring to the above example, interfaces have a name, and various default attributes.

`:y`          sets the starting row point. (See Geometry)
`:x`          sets the starting column point.
`:width`      sets how many characters wide the interface will be.
`:height`     sets how many characters tall the interface will be.

`:foreground` sets the default foreground colour. (See Colours)
`:background` sets the default background colour.

`:cursor`     a boolean specifying whether the cursor should show.

`:layer`      an integer specifying the z-index of the interface.
              (See Layers)

### On Defining Commands

    command :do_something, { entity:   SomeClass,
                             keypress: 's',
                             keyword:  'start' }

As above, commands have a name, a class which performs the action
(you define this), and they can be invoked with a keypress or a keyword.


### Geometry

Geometry for Vedeu, as the same for ANSI terminals, is set top-left, which is point 1, 1. Interfaces have internal geometry which is handled automatically. Unless you are doing something special, you will probably only set it on a per-interface basis.


### Colours

Vedeu uses the standard ANSI terminal colours, though you can also set arbitrary colours using HTML/CSS style notation (i.e. '#aadd00').

    :black, :red, :green, :yellow, :blue, :magenta, :cyan, :white, :default


### Layers

Vedeu allows the overlaying of interfaces. To render these correctly,
Vedeu uses two rules.

  1) The :layer value. 0 would be default, or bottom. 1 would be placed on top of 0. 2 on top of 1, and so on.
  2) If two interfaces occupy the same 'space', the interface which was defined last, wins.


## Contributing

1. Fork it ( http://github.com/<my-github-username>/vedeu/fork )
2. Clone it
3. `bundle`
4. `rake` or `bundle exec guard`
5. Create your feature branch (`git checkout -b my-new-feature`)
6. Write some tests, write some code, have some fun
7. Commit your changes (`git commit -am 'Add some feature'`)
8. Push to the branch (`git push origin my-new-feature`)
9. Create new Pull Request
