require 'binding_of_caller'

module Stackdo
  class Location < Struct.new(:file, :line)
    def to_s
      "#{file}:#{line}"
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
    attr_reader :location, :environment

    def self.from_binding(binding)
      file = binding.eval("__FILE__")
      line = binding.eval("__LINE__")

      Stackdo::Frame.new(
        location: Location.new(file, line),
        environment: Environment.from_binding(binding)
      )
    end

    def initialize(location:, environment:)
      @location = location
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

