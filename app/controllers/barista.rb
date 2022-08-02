require 'orders/use_case/get_orders_by_status'
require 'orders/use_case/update_order_status'
require 'order_status'

class Barista
  attr_accessor :currently_processing_order

  def initialize(order_gateway)
    @order_gateway = order_gateway
  end

  def begin_processing_next_order
    @currently_processing_order = GetOrdersByStatus.new(GetOrdersByStatus::Request(OrderStatus::PROCESSING, 1))
    unless currently_processing_order.nil?
      UpdateOrderStatus.new(@currently_processing_order.id, OrderStatus::PROCESSING)
    end
  end

  def complete_current_order
    unless @currently_processing_order.nil?
      puts("Order for " + @currently_processing_order.customers_name + " ready!")
      UpdateOrderStatus.new(@currently_processing_order.id, OrderStatus::PROCESSED)
    end
  end
end