require "order_error"
require 'invalid_beverage_error'
require "orders_list"

class Cashier

  def initialize(orders)
    @orders = orders
  end

  def start_customers_order(customers_name)
    order = @orders.add_order(customers_name)
    return order.id
  end

  def add_beverage_to_order(order_id, new_beverage)
    if new_beverage.nil?
      raise InvalidBeverageError
    end

    order = get_customers_order(order_id)
    order.add_beverage(new_beverage)
    return order
  end


  private
  def get_customers_order(order_id)
    order = @orders.get_order(order_id)
    if order.nil?
      raise OrderError
    end

    return order
  end
end