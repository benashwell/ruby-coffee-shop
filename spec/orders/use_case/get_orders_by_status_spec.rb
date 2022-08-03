require 'rspec'
require 'orders/domain/order'
require 'orders/gateway/in_memory_order'
require 'orders/use_case/get_orders_by_status'
require 'orders/domain/order_status'

describe Orders::UseCase::GetOrdersByStatus do
  before do
    @gateway = instance_double(Orders::Gateway::InMemoryOrder)
  end

  context 'when getting orders list by status' do
    subject do
      described_class.new(gateway: @gateway).get_orders_by_status(request)
    end

    context 'gets a singular order with correct status'do
      let(:request) { Orders::UseCase::GetOrdersByStatus::Request.new(Orders::Domain::OrderStatus::PENDING, 1)  }
      it {
        order = Orders::Domain::Order.new(customers_name: "Ben")
        expect(@gateway).to receive(:get_orders_by_status).with({status: Orders::Domain::OrderStatus::PENDING, count: 1}).and_return([order])
        is_expected.to eq([order])
      }
    end

    context 'gets multiple orders with correct status'do
      let(:request) { Orders::UseCase::GetOrdersByStatus::Request.new(Orders::Domain::OrderStatus::PENDING, 3)  }
      it {
        order1 = Orders::Domain::Order.new(customers_name: "Ben")
        order2 = Orders::Domain::Order.new(customers_name: "Steve")
        order3 = Orders::Domain::Order.new(customers_name: "Dave")
        expect(@gateway).to receive(:get_orders_by_status).with({status: Orders::Domain::OrderStatus::PENDING, count: 3}).and_return([order1, order2, order3])
        is_expected.to eq([order1, order2, order3])
      }
    end
  end
end
