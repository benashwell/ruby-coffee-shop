require 'coffee'
require 'invalid_beverage_error'
require 'orders/domain/order'

describe ".add_beverage" do
  before(:each) do
    @order = Orders::Domain::Order.new(customers_name: "Ben")
  end

  context "add an empty beverage to order" do
    it "raises an invalid beverage error" do
      expect{@order.add_beverage(nil)}.to raise_error(InvalidBeverageError)
    end
  end

  context "add an invalid beverage to order" do
    it "raises an invalid beverage error" do
      expect{@order.add_beverage("not a beverage")}.to raise_error(InvalidBeverageError)
    end
  end

  context "add a beverage to order" do
    it "order contains beverage" do
      @order.add_beverage(Coffee.new)
      expect(@order.beverages.length).to eq(1)
    end
  end
end
