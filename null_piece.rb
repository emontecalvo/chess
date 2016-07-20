require_relative "null_object"
require "singleton"

class NullPiece < NullObject
  include Singleton

  def msg
    puts "I am a singleton"
  end

  def symbol
    "   "
  end

  def color
    :null
  end

end

null = NullPiece.instance
p null.color
