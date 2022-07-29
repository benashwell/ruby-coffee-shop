require "order_error"
require "orders"
require "order"

class Cashier

  def initialize(orders)
    @orders = orders
  end

  def take_customers_order(customers_name)
    if customers_name.nil? || customers_name.empty?
      raise OrderError.new
    end

    @orders.add_order(Order.new(customers_name))
    return true
  end

end