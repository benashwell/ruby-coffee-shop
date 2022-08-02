require 'orders/use_case/create_customer_order'

class CashierController

  def initialize(order_gateway)
    @order_gateway = order_gateway
  end

  def start_customers_order(customers_name)
    request = CreateCustomerOrder.Request.new(customers_name)
    return CreateCustomerOrder.new(@order_gateway).create_customer_order(request)
  end

end