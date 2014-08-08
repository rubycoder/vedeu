require 'vedeu/instrumentation'
require 'vedeu/api/interface'
require 'vedeu/support/events'
require 'vedeu/support/interface_store'
require 'vedeu/api/view'
require 'vedeu/models/geometry'
require 'vedeu/support/menu'
require 'vedeu/output/view'
require 'vedeu/launcher'

# Todo: mutation (events)

module Vedeu
  # :nocov:
  def self.debug?
    false
  end

  Vedeu::Instrumentation::Trace.call if debug?

  module API
    def interface(name, &block)
      Interface.save(name, &block)
    end

    def on(name, delay = 0, &block)
      Vedeu.events.on(name, delay, &block)
    end
    alias_method :event, :on

    def trigger(name, *args)
      Vedeu.events.trigger(name, *args)
    end
    alias_method :run, :trigger

    def with(name, &block)
      InterfaceStore.query(name)
    end

    def view(name = '', &block)
      Vedeu::API::View.build(name, &block)
    end
  end

  def self.events
    @events ||= Events.new do
      on(:_exit_)        { fail StopIteration }
      on(:_log_)         { |message| Vedeu.log(message) }
      on(:_mode_switch_) { fail ModeSwitch    }

      on(:_keypress_) do |key|
        trigger(:key, key)
        trigger(:_log_, (' ' * 42) + "key: #{key}")
        trigger(:_mode_switch_) if key == :escape
      end
    end
  end

  def self.log(message)
    Vedeu::Instrumentation::Log.logger.debug(message)
  end

  def self.error(exception)
    Vedeu::Instrumentation::Log.error(exception)
  end

  def self.included(receiver)
    receiver.send(:include, API)
    receiver.extend(API)
  end

  extend API
  # :nocov:
end
