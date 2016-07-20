
class ColorError < ArgumentError

  def msg
    "Not your color"
  end
end

class InvalidMoveError < ArgumentError

  def msg
    "Not a valid move for that piece"
  end

end

class SelfInCheckError < ArgumentError

  def msg
    "You can't put yourself in check"
  end

end
