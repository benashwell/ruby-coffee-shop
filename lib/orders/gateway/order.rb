require 'orders/domain/order'

module Orders
  module Gateway
    class Order

      def initialize
        @orders = Array.new

        #Order count for ID population
        @order_count = 1
      end

      #Gateway method to create the order - this implementation means that we can create in memory currently but could be out to db or file etc
      def create_order(attributes)
        order = Orders::Domain::Order.new(attributes)
        order.id = @order_count
        @orders << order
        @order_count += 1
        return order.id
      end

      def get_order(order_id)
        if order_id.nil?
          raise OrderError
        end

        return @orders.detect { |order| order.id == order_id }
      end
    end
  end
end