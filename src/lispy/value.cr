module Lispy
  class Value
    @@nil = Value.new(:nil)

    def self.nil()
      @@nil
    end

    @value : Symbol | String | Float32 | Array(Value)

    def initialize(@value)
    end

    def to_s(): String
      case @value
      when Array(Value)
      	result = "("
      	@value.as(Array(Value)).each { |v|
          result += v.to_s() + " "
      	}
      	result[0..result.size - 2] + ")"
      else
        @value.to_s()
      end
    end
  end
end
