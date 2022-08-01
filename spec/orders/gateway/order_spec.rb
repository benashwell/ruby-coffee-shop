require 'rspec'
require 'order_error'
require 'orders/gateway/order'

describe Orders::Gateway::Order do

  context 'when create order' do
    subject do
      described_class.new.create_order(
        customers_name: customers_name
      )
    end

    context 'with a customers name' do
      let(:customers_name) { 'Ben' }
      it { is_expected.to eq(1)}
    end

    context 'without a customers name' do
      let(:customers_name) { nil }
      it { expect {subject }.to raise_error(OrderError) }
    end
  end
end
