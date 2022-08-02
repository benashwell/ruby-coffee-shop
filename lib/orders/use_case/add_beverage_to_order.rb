module Orders
  module UseCase
    class AddBeverageToOrder
      Request = Struct.new(:order_id, :beverage)

      attr_reader :gateway

      def initialize(gateway: Gateway::Order.new)
        @gateway = gateway
      end

      def add_beverage_to_order(request)
        unless request[:beverage].class.ancestors.include?(Beverage)
          raise InvalidBeverageError.new
        end

        order = get_order_by_id(request.order_id)

        order.beverages << request.beverage
      end

      private
      def get_order_by_id(order_id)
        order = @gateway.get_order(order_id.to_i)

        if order.nil?
          raise OrderError
        end

        return order
      end
    end
  end
end