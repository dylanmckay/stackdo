#! /usr/bin/env ruby

require_relative '../lib/stackdo'

stack = Stackdo::CallStack.from_here

stack.walk do |frame|
  puts "#{frame.location}"

  frame.environment.variables.each do |variable|
    puts "#{variable.name} = #{variable.value.to_s}"
  end

  puts
end
