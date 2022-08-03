require 'orders/domain/order_error'

module Orders
  module UseCase
    class UpdateOrderStatus
      Request = Struct.new(:order_id, :status)

      attr_reader :gateway

      def initialize(gateway)
        @gateway = gateway
      end

      def update_orders_status(request)
        order = @gateway.get_order(request[:order_id])
        raise Orders::Domain::OrderError if order.nil?
        order.status = request[:status]
        @gateway.update_order(order)
      end
    end
  end
end