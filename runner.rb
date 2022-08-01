require 'orders'
require 'cashier'
require 'barista'
require 'coffee'

def main
  orders = Orders.new
  cashier = Cashier.new(orders)
  barista = Barista.new(orders)

  open = true
  while open
    puts "What is your name?"
    name = gets.chomp
    order_id = cashier.start_customers_order(name)
    puts("Waiting on order " + order_id.to_s)
    barista.begin_processing_next_order
    barista.process_order(orders.get_processing_orders[0])
    barista.complete_current_order
  end
end

main