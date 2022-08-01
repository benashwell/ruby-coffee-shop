require 'rspec'
require 'orders/use_case/create_customer_order'
require 'orders/gateway/order'

describe Orders::UseCase::CreateCustomerOrder do
  before do
    @gateway = instance_double(Orders::Gateway::Order)
  end

  context 'when creating a customer order' do
    subject do
      described_class.new(gateway: @gateway).create_customer_order(request)
    end

    context 'call gateway to create the order'do
      let(:request) { Orders::UseCase::CreateCustomerOrder::Request.new(customers_name: 'Ben')  }
      it {
        expect(@gateway).to receive(:create_order).and_return(1)
        is_expected.to eq(Orders::UseCase::CreateCustomerOrder::Response.new(order_id: 1))
      }
    end

  end
end
