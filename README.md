# Get detailed stacktraces

Get stacktraces and the variables within.

## Example

``` ruby
require_relative '../lib/stackdo'

stack = Stackdo::CallStack.from_here

stack.walk do |frame|
  puts frame.location
  puts frame.method_reference

  frame.environment.variables.each do |variable|
    puts "#{variable.name} = #{variable.value || 'nil'}"
  end

  puts
end
```

