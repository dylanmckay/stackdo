require 'binding_of_caller'

module Stackdo
  class Error < StandardError; end

  class Location < Struct.new(:file, :line)
    def to_s
      "#{file}:#{line}"
    end
  end

  class MethodReference < Struct.new(:receiver, :name)
    def to_s
      case receiver
      when Module then "#{receiver}.#{name}"
      when Class then "#{receiver}##{name}"
      else
        receiver.to_s
      end
    end
  end

  class Variable
    attr_reader :name, :value

    def initialize(name, value)
      @name = name
      @value = value
    end
  end

  class Environment
    attr_reader :variables

    def self.from_binding(binding)
      local_variables = binding.local_variables.map do |local|
        Variable.new(local, binding.local_variable_get(local))
      end

      Environment.new(
        variables: local_variables,
      )
    end

    def initialize(variables:)
      @variables = variables
    end
  end

  class Frame
    attr_reader :location, :method_reference, :environment

    def self.from_binding(binding)
      file = binding.eval("__FILE__")
      line = binding.eval("__LINE__")
      method_name = binding.eval("__method__")

      Stackdo::Frame.new(
        location: Location.new(file, line),
        method_reference: MethodReference.new(binding.receiver, method_name),
        environment: Environment.from_binding(binding)
      )
    end

    def initialize(location:, method_reference:, environment:)
      @location = location
      @method_reference = method_reference
      @environment = environment
    end
  end

  class CallStack
    attr_reader :frames

    def self.from_here
      frames = Stackdo::call_stack_bindings(binding).map do |binding|
        Stackdo::Frame.from_binding(binding)
      end

      CallStack.new(frames: frames)
    end

    def initialize(frames:)
      @frames = frames
    end

    def walk(&block)
      frames.each(&block)
    end
  end

  def self.call_stack_bindings(binding)
    bindings = []

    n = 0
    loop do
      binding = binding.of_caller(n) rescue break
      n += 1

      bindings << binding
    end

    bindings
  end
end

