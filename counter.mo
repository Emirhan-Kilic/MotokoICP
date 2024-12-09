actor test {

  var counter: Nat = 10;

  public func pl(): async Nat {
    counter += 1; // Persistently increase counter
    return counter;
  };

  public func con(): async Nat {
    if (counter != 0) {
      counter -= 1; // Persistently decrease counter
    };
    return counter;
  };

  public func addValue(value: Nat): async Nat{
    counter += value;
    return counter;
  }

}
