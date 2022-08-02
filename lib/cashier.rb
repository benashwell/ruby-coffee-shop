require "order_error"
require 'invalid_beverage_error'
require "orders_list"
require 'orders/use_case/add_beverage_to_order'

class Cashier

  def initialize(orders, order_gateway)
    @orders = orders
    @order_gateway = order_gateway
  end

  def start_customers_order(customers_name)
    order = @orders.add_order(customers_name)
    return order.id
  end

end