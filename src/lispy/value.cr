require "./state"

module Lispy
  class ValueError < Exception
  end

  class Symbol
    protected property value : String

    def initialize(@value)
    end

    def to_s : String
      @value
    end
  end

  class Value
    class_getter nil : Value = Value.new(:nil)

    protected property value : ::Symbol | Symbol | String | Int32 | Float32 | Array(Value) | Proc(State, Value, Value)

    def initialize(@value)
    end

    def size : Int
      if !@value.is_a?(Array(Value))
        raise ValueError.new("cannot get size; value is not a list")
      end
      @value.as(Array(Value)).size
    end

    def car : Value
      self[0]
    end

    def cdr : Value
      self[0..-1]
    end

    def [](idx : Int) : Value
      if !@value.is_a?(Array(Value))
        raise ValueError.new("cannot get element #{idx} value is not a list")
      end
      @value.as(Array(Value))[idx]
    end

    def [](range : Range(Int, Int)) : Value
      if !@value.is_a?(Array(Value))
        raise ValueError.new("cannot get elements #{range} value is not a list")
      end
      @value.as(Array(Value))[range]
    end

    def [](start : Int, count : Int) : Value
      self[start..(start + count)]
    end

    def ==(rhs : Value)
      @value == rhs.value
    end

    def <<(rhs : Value)
      if !@value.is_a?(Array(Value))
        raise ValueError.new("cannot get elements #{range} value is not a list")
      end
      @value << rhs
    end

    def to_s : String
      case @value
      when Array(Value)
        result = "("
        @value.as(Array(Value)).each { |v|
          result += v.to_s + " "
        }
        result[0..result.size - 2] + ")"
      when String
        result = "\""
        result += @value.as(String)
        result += "\""
        result
      else
        @value.to_s
      end
    end
  end
end
