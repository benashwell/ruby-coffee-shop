require 'rspec'
require 'orders/use_case/update_order_status'
require 'orders/domain/order_error'

describe Orders::UseCase::UpdateOrderStatus do
  before do
    @gateway = instance_double(Orders::Gateway::Order)
  end

  context 'updating an orders status' do
    subject do
      described_class.new(gateway: @gateway).update_orders_status(request)
    end

    context 'when the order does not exist' do
      let(:request) { Orders::UseCase::UpdateOrderStatus::Request.new(5000, Orders::Domain::OrderStatus::PROCESSED) }
      it {
        expect(@gateway).to receive(:get_order).with(5000).and_return(nil)
        expect { subject }.to raise_error(Orders::Domain::OrderError)
      }
    end

    context 'updates the order status' do
      let(:request) { Orders::UseCase::UpdateOrderStatus::Request.new(1, Orders::Domain::OrderStatus::PROCESSED) }
      it {
        order = Orders::Domain::Order.new(customers_name: "Ben")
        expect(@gateway).to receive(:get_order).with(1).and_return(order)
        expect(@gateway).to receive(:update_order)
        subject
        expect(order.status).to eq(Orders::Domain::OrderStatus::PROCESSED)
      }
    end
  end
end
