require "cashier"
require "order_error"
require "orders"
require "invalid_beverage_error"

def get_order(id = nil, name)
  order = Order.new(name)
  order.id = id
  return order
end

describe ".start_customers_order" do
  let(:orders) {instance_double(Orders)}

  before(:each) do
    @cashier = Cashier.new(orders)
  end

  context "Coffee ordered with name" do
    it "order is accepted and order id is returned" do
      order = get_order(1, "Ben")
      allow(orders).to receive(:add_order).and_return(order)
      expect(@cashier.start_customers_order("Ben")).to eq(1)
    end
  end
end

describe ".add_beverage_to_order" do
  let(:orders) {instance_double(Orders)}

  before(:each) do
    @cashier = Cashier.new(orders)
  end

  context "nil item added to order" do
    it "raises an InvalidItemError" do
      expect{@cashier.add_beverage_to_order(1, nil)}.to raise_error(InvalidBeverageError)
    end
  end

  context "item added to non existing order" do
    it "raises an OrderError" do
      expect(orders).to receive(:get_order).with(99).and_return(nil)
      expect{@cashier.add_beverage_to_order(99, Coffee.new)}.to raise_error(OrderError)
    end
  end

  context "valid item added to order" do
    it "item added to order" do
      order = get_order(1, "Ben")
      coffee = Coffee.new
      expect(orders).to receive(:get_order).with(1).and_return(order)
      result = @cashier.add_beverage_to_order(1, coffee)
      expect(result.beverages.size).to eq(1)
      expect(result.beverages[0]).to eq(coffee)
    end
  end
end