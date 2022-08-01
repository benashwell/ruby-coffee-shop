module Orders
  module UseCase
    class CreateCustomerOrder
      #create classes to hold request and response attributes
      Request = Struct.new(:customer_name)
      Response = Struct.new(:order_id)

      attr_reader :gateway

      #Take gateway as a parameter so as long as it has the create_order method we dont care what the implementation is
      def initialize(gateway: Gateway::Order.new)
        @gateway = gateway
      end

      #Implementation of the create customer order use case
      def create_customer_order(request)
        order_id = gateway.create_order(request.to_h)
        return Response.new(order_id: order_id)
      end
    end
  end
end