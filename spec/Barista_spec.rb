require "orders"
require "order"
require "barista"
require "order_status"

describe ".begin_processing_next_order" do
  before(:each) do
    @orders = Orders.new
    @barista = Barista.new(@orders)
  end

  context "No orders have come in" do
    it "processes no orders" do
      @barista.begin_processing_next_order
      expect(@barista.currently_processing_order).to be_nil
    end
  end

  context "only processed order is in queue" do
    it "processes no orders" do
      @orders.add_order("Ben", OrderStatus::PROCESSED)
      @barista.begin_processing_next_order
      expect(@barista.currently_processing_order).to be_nil
    end
  end

  context "pending order is moved to processing" do
    it "order is now processing" do
      @orders.add_order("Ben", OrderStatus::PENDING)
      @barista.begin_processing_next_order
      expect(@barista.currently_processing_order.customers_name).to eq("Ben")
      expect(@barista.currently_processing_order.status).to eq(OrderStatus::PROCESSING)
    end
  end
end

describe ".complete_current_order" do
  before(:each) do
    @orders = Orders.new
    @barista = Barista.new(@orders)
  end

  context "No current order processing" do
    it "processes no orders" do
      @barista.complete_current_order
      expect(@barista.currently_processing_order).to be_nil
      expect(@orders.get_processed_orders.length).to eq(0)
    end
  end

  context "current order processed" do
    it "calls the customer by name" do
      @barista.currently_processing_order = @orders.add_order("Ben", OrderStatus::PROCESSED)
      expect do
        @barista.complete_current_order
      end.to output("Order for Ben ready!\n").to_stdout
    end
  end

  context "current order processing" do
    it "order status changes to processed" do
      order = @orders.add_order("Ben", OrderStatus::PROCESSING)
      @barista.currently_processing_order = order
      @barista.complete_current_order
      expect(@barista.currently_processing_order).to eq(order)
      expect(@orders.get_processed_orders.length).to eq(1)
      expect(@orders.get_processed_orders[0].customers_name).to eq("Ben")
      expect(@orders.get_processed_orders[0].status).to eq(OrderStatus::PROCESSED)
    end
  end
end

describe ".process_order" do
  before(:each) do
    @orders = Orders.new
    @barista = Barista.new(@orders)
  end

  context "order not provided" do
    it "order error raised" do
      expect { @barista.process_order(nil) }.to raise_error(OrderError)
    end
  end

  context "order to process" do
    it "order is processed" do
      order = Order.new("Ben", OrderStatus::PROCESSING)
      expect do
        @barista.process_order(order)
      end.to output("making order for Ben\n").to_stdout
    end
  end
end