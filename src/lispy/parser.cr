require "./value"

module Lispy
  class Parser
    @@PARSE_END = Value.new(:PARSE_END)
    @line = 0
    @col = 0

    def initialize(data : String)
      @data = IO::Memory.new(data)
    end


    def to_s(): String

    end

    private def skipBlank()
      while @data.peek()
    end

    def parse(): Value

    end
  end
end
