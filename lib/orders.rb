require "order"

class Orders
  attr_reader :orders

  def initialize
    @orders = []
  end

  def add_order(order)
    @orders << order
  end

  def get_processing_orders
    return get_orders_by_status("PROCESSING")
  end

  def get_processed_orders
    return get_orders_by_status("PROCESSED")
  end

  def get_orders_by_status(status)
    processing_orders = []
    @orders.each do |order|
      if order.status == status
        processing_orders << order
      end
    end
    return processing_orders
  end

  def get_next_pending_order
    return @orders.detect { |order| order.status == "PENDING" }
  end

  def update_order_status(order, new_status)
    index = @orders.index(order)
    order.status = new_status
    @orders[index] = order
  end
end