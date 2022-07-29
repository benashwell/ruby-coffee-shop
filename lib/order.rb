class Order
  @@order_count = 0
  attr_accessor :id, :customers_name, :status

  def initialize(name, status = OrderStatus::PENDING)
    @customers_name = name
    @status = status
    @id = @@order_count
    @@order_count += 1
  end

  def process_order
    puts("making order for " + customers_name)
  end
end