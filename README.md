# Stackdo

[![Build Status](https://travis-ci.org/dylanmckay/stackdo.svg?branch=master)](https://travis-ci.org/dylanmckay/stackdo)
[![Gem Version](https://badge.fury.io/rb/stackdo.svg)](https://badge.fury.io/rb/stackdo)
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE)

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

