require "./value"

module Lispy
  class Parser
    @line = 0
    @col = 0
  
    def initialize(data: String)
      @data = IO::Memory.new(data)
    end


    def to_s(): String
      
    end

    def parse(): Value

    end
  end
end