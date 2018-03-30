$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'slipstream'
require 'pry'

begin
  stream = Slipstream.create
  binding.pry
ensure
  stream.close!
end
