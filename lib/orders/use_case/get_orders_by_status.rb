module Orders
  module UseCase
    class GetOrdersByStatus
      Request = Struct.new(:status, :count)

      attr_reader :gateway

      def initialize(gateway)
        @gateway = gateway
      end

      def get_orders_by_status(request)
        return @gateway.get_orders_by_status(request.to_h)
      end
    end
  end
end