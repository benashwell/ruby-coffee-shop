require 'rspec'
require "cashier"
require "order_error"
require "orders_list"
require "invalid_beverage_error"
require 'orders/domain/order'
require 'orders/gateway/order'

def get_order(id = nil, name)
  order = Orders::Domain::Order.new(customers_name: name)
  order.id = id
  return order
end

describe ".start_customers_order" do
  let(:orders) {instance_double(OrdersList)}
  let(:order_gateway) {instance_double(Orders::Gateway::Order)}

  before(:each) do
    @cashier = Cashier.new(orders, order_gateway)
  end

  context "Coffee ordered with name" do
    it "order is accepted and order id is returned" do
      order = get_order(1, "Ben")
      allow(orders).to receive(:add_order).and_return(order)
      expect(@cashier.start_customers_order("Ben")).to eq(1)
    end
  end
end
