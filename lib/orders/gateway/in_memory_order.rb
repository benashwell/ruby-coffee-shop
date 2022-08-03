require 'orders/domain/order'
require 'orders/domain/order_error'

module Orders
  module Gateway
    class InMemoryOrder

      def initialize
        @orders = Array.new

        #InMemoryOrder count for ID population
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
          raise Orders::Domain::OrderError
        end

        return @orders.detect { |order| order.id == order_id }
      end

      def get_orders_by_status(attributes)
        found_orders = []
        @orders.each do |order|
          break if found_orders.length >= attributes.count
          found_orders << order if order.status == attributes[:status]
        end
        return found_orders
      end

      def update_order(order)
        existing_order = get_order(order.id)
        raise Orders::Domain::OrderError if existing_order.nil?
        @orders[@orders.index(existing_order)] = order
      end
    end
  end
end