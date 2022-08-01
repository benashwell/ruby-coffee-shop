require 'order_status'
require 'order_error'

module Orders
  module Domain
    class Order
      #Order domain object
      attr_accessor :id, :customers_name, :status, :beverages

      #Using param: to be able to pass hash value into initialize method
      def initialize(customers_name:, status: OrderStatus::PENDING)
        if customers_name.nil?
          raise OrderError.new
        end

        @customers_name = customers_name
        @status = status
        @beverages = []
      end

      #todo to be refactored next
      def add_beverage(beverage)
        unless beverage.class.ancestors.include?(Beverage)
          raise InvalidBeverageError.new
        end

        @beverages << beverage
      end
    end
  end
end