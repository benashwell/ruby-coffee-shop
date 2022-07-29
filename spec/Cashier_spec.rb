require "cashier"
require "order_error"
require "orders"

describe ".take_customers_order" do
  let(:orders) {instance_double(Orders)}

  before(:each) do
    @cashier = Cashier.new(orders)
  end

  context "Coffee ordered with name" do
    it "order is accepted and order id is returned" do
      order = Order.new("Ben")
      order.id = 1
      allow(orders).to receive(:add_order).and_return(order)
      expect(@cashier.take_customers_order("Ben")).to eq(1)
    end
  end
end