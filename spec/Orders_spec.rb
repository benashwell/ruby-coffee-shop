require "orders_list"
require 'order_error'

describe ".add_order" do
  before(:each) do
    @orders = OrdersList.new
  end

  context "add an order with no customer name" do
    it "raises an order error" do
      expect{@orders.add_order(nil)}.to raise_error(OrderError)
    end
  end

  context "add an order with an empty name" do
    it "returns an OrderError" do
      expect { @orders.add_order("") }.to raise_error(OrderError)
    end
  end

  context "add an order with a name" do
    it "adds order to orders list" do
      @orders.add_order("Ben")
      expect( @orders.orders.length).to eq(1)
    end
  end

  context "add an order with a name" do
    it "returns the created order" do
      order = @orders.add_order("Ben")
      expect( order.customers_name).to eq("Ben")
    end
  end

end