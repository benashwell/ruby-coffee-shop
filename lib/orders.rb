require "order"
require 'order_error'
require 'order_status'

class Orders
  attr_reader :orders

  def initialize
    @orders = []
  end

  def add_order(customer_name, order_status = OrderStatus::PENDING)
    if customer_name.nil? || customer_name.empty?
      raise OrderError.new
    end

    order = Order.new(customer_name, order_status)
    @orders << order
    return order
  end

  def get_processing_orders
    return get_orders_by_status(OrderStatus::PROCESSING)
  end

  def get_processed_orders
    return get_orders_by_status(OrderStatus::PROCESSED)
  end

  def get_next_pending_order
    return @orders.detect { |order| order.status == OrderStatus::PENDING }
  end

  def update_order_status(order, new_status)
    index = @orders.index(order)
    order.status = new_status
    @orders[index] = order
  end

  private
  def get_orders_by_status(status)
    found_orders = []
    @orders.each do |order|
      if order.status == status
        found_orders << order
      end
    end
    return found_orders
  end
end