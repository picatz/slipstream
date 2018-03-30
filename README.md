# Slipstream
> Simple API for IPC (inter-process communication) using IO pipes.

## Installation

    $ gem install slipstream

## Usage

```ruby
require 'slipstream'

# create a new stream
stream = Slipstream.create

# if blocking, nothing will be read or printed
print stream.read 

# fork'd processes can observe the stream
child = fork do 
  loop do
    print stream.read
  end
end

# write to the stream, notice that it's printed to the scren
stream.write "Hello world!"

# close the stream
stream.close!
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
