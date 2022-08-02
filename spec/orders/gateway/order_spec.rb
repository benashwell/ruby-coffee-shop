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

  context 'when getting an order' do
    before(:context) do
      @under_test = described_class.new
    end

    subject do
      @under_test.get_order(order_id)
    end

    context 'with a nil order id' do
      let(:order_id) {nil}
      it { expect{subject}.to raise_error(OrderError) }
    end

    context 'with an order id that does not exist' do
      let(:order_id) {5000}
      it { expect(subject).to be_nil }
    end

    context 'with an order id that does exist' do
      let(:order_id) {1}
      it {
        @under_test.create_order(customers_name: "Ben")
        expect(subject).to_not be_nil
        expect(subject.customers_name).to eq("Ben")
      }
    end
  end
end
