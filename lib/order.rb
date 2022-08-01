require 'beverage'
require 'invalid_beverage_error'

class Order
  #Class variable order count
  @@order_count = 0
  attr_accessor :id, :customers_name, :status, :beverages

  def initialize(name, status = OrderStatus::PENDING)
    #Set ID and increment order count for future orders
    @id = @@order_count
    @@order_count += 1

    @customers_name = name
    @status = status
    @beverages = []
  end

  def process_order
    puts("making order for " + customers_name)
  end

  def add_beverage(beverage)
    unless beverage.class.ancestors.include?(Beverage)
      raise InvalidBeverageError.new
    end

    @beverages << beverage
  end
end