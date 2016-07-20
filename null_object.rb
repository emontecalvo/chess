class NullObject
  def method_missing(*args, &block)
    nil
  end

  def inspect
    "null"
  end

end
