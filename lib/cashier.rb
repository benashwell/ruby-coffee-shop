require "order_error"
require "orders"
require "order"

class Cashier

  def initialize(orders)
    @orders = orders
  end

  def take_customers_order(customers_name)
    order = @orders.add_order(customers_name)
    return order.id
  end

end