require 'invalid_beverage_error'

class Beverage

  def initialize
    #Cannot instantiate beverage directly
    raise InvalidBeverageError
  end
end
