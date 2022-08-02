require 'orders/domain/invalid_beverage_error'

module Orders
  module Domain
    class Beverage

      def initialize
        #Cannot instantiate beverage directly
        raise InvalidBeverageError
      end
    end
  end
end
