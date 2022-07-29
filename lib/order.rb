class Order
  attr_accessor :customers_name, :status

  def initialize(name, status = OrderStatus::PENDING)
    @customers_name = name
    @status = status
  end

  def process_order
    puts("making order for " + customers_name)
  end
end