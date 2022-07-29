require "orders"
require "order"
require 'order_error'

describe ".add_order" do
  before(:each) do
    @orders = Orders.new
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

  context "add an order with a name" do
    it "returns order with an id" do
      order = @orders.add_order("Ben")
      expect( order.id).to_not be_nil
    end
  end

  context "add multiple successful orders" do
    it "have multiple orders with different ids" do
      order = @orders.add_order("Ben")
      order2 = @orders.add_order("Steve")
      expect( order.id).to_not eq(order2.id)
    end
  end
end