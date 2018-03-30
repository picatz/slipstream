require 'securerandom'
require 'slipstream/version'

module Slipstream
  def self.create(**options)
    Stream.new(options)
  end

  class Stream  
    attr_accessor :buffer_size
    attr_accessor :clean
    def initialize(**options)
      if options[:id].nil?
        @id = SecureRandom.uuid 
      else
        @id = options[:id]
      end
      if options[:buffer_size].nil?
        @buffer_size = 1
      else
        @buffer_size = options[:buffer_size]
      end
      @clean = true if options[:clean]
      @reader, @writer = IO.pipe
    end

    def read(clean: clean?)
      buffer = ""
      buffer << @reader.read_nonblock(@buffer_size) while buffer[-1] != "\n"
      if @clean
        return buffer.strip
      else
        return buffer
      end
    rescue IO::EAGAINWaitReadable
      return nil 
    rescue IOError
      return false
    end

    def id
      @id
    end

    def write(mesg)
      @writer.puts mesg
      return true
    rescue IOError
      return false
    end

    def clean!
      @clean = true
    end

    def clean?
      return true if @clean
      false
    end

    def unclean!
      @clean = false
    end

    def close!
      @writer.close 
      @reader.close 
      return true
    end
  end
end
