require "cashier"
require "order_error"

describe ".take_customers_order" do
  before(:each) do
    @orders = Orders.new
    @cashier = Cashier.new(@orders)
  end

  context "No name given" do
    it "returns an OrderError" do
      expect { @cashier.take_customers_order(nil) }.to raise_error(OrderError)
    end
  end

  context "Empty name given" do
    it "returns an OrderError" do
      expect { @cashier.take_customers_order("") }.to raise_error(OrderError)
    end
  end

  context "Coffee ordered with name" do
    it "coffee order is added to orders queue" do
      @cashier.take_customers_order("Ben")
      expect(@orders.orders.length).to eq(1)
      expect(@orders.orders[0].customers_name).to eq("Ben")
    end
  end

  context "Coffee ordered with name" do
    it "order is accepted" do
      expect(@cashier.take_customers_order("Ben")).to eq(true)
    end
  end
end