module Orders
  module UseCase
    class UpdateOrderStatus
      Request = Struct.new(:order_id, :status)

      attr_reader :gateway

      def initialize(gateway: Gateway::Order.new)
        @gateway = gateway
      end

      def update_orders_status(request)
        order = @gateway.get_order(request[:order_id])
        order.status = request[:status]
        @gateway.update_order(order)
      end
    end
  end
end