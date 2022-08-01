require "orders_list"
require 'order_status'
class Barista
  attr_accessor :currently_processing_order

  def initialize(orders)
    @orders = orders
  end

  def begin_processing_next_order
    @currently_processing_order = @orders.get_next_pending_order
    unless currently_processing_order.nil?
      @orders.update_order_status(@currently_processing_order, OrderStatus::PROCESSING)
    end
  end

  def complete_current_order
    unless @currently_processing_order.nil?
      puts("Order for " + @currently_processing_order.customers_name + " ready!")
      @orders.update_order_status(@currently_processing_order, OrderStatus::PROCESSED)
    end
  end
end