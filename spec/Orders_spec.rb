require "orders"
require "order"
require 'order_error'

describe ".add_order" do
  before(:each) do
    @orders = Orders.new
  end

  context "add an empty order" do
    it "raises an order error" do
      expect{@orders.add_order(nil)}.to raise_error(OrderError)
    end
  end
end