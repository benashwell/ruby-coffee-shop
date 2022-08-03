require 'rspec'
require 'orders/domain/order_error'
require 'orders/gateway/in_memory_order'
require 'orders/domain/order'

describe Orders::Gateway::InMemoryOrder do

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
      it { expect {subject }.to raise_error(Orders::Domain::OrderError) }
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
      it { expect{subject}.to raise_error(Orders::Domain::OrderError) }
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

  context 'when getting an order by status' do
    before(:each) do
      @under_test = described_class.new
    end

    subject do
      @under_test.get_orders_by_status(
        status: status,
        count: count
      )
    end

    context 'when an order exists with that status and we want just one' do
      let(:status) { Orders::Domain::OrderStatus::PENDING }
      let(:count) { 1 }
      it {
        @under_test.create_order(customers_name: "Ben", status: Orders::Domain::OrderStatus::PENDING)
        expect(subject.length).to eq(1)
        expect(subject[0].customers_name).to eq("Ben")
        expect(subject[0].status).to eq(Orders::Domain::OrderStatus::PENDING)
      }
    end

    context 'when an order exists with that status and we want just more than one' do
      let(:status) { Orders::Domain::OrderStatus::PENDING }
      let(:count) { 2 }
      it {
        @under_test.create_order(customers_name: "Ben", status: Orders::Domain::OrderStatus::PENDING)
        expect(subject.length).to eq(1)
        expect(subject[0].customers_name).to eq("Ben")
        expect(subject[0].status).to eq(Orders::Domain::OrderStatus::PENDING)
      }
    end

    context 'when an order does not exist with that status' do
      let(:status) { Orders::Domain::OrderStatus::PROCESSING }
      let(:count) { 2 }
      it {
        @under_test.create_order(customers_name: "Ben", status: Orders::Domain::OrderStatus::PENDING)
        expect(subject.length).to eq(0)
      }
    end
  end

  context 'when updating an order' do
    before(:each) do
      @under_test = described_class.new
    end

    subject do
      @under_test.update_order(order)
    end

    context 'order does not exist' do
      let(:order) {
        order = Orders::Domain::Order.new(customers_name: "Ben Updated")
        order.id = 5000
        return order
      }
      it {
        @under_test.create_order(customers_name: "Ben", status: Orders::Domain::OrderStatus::PENDING)
        expect{ subject }.to raise_error(Orders::Domain::OrderError)
      }
    end

    context 'order name is updated' do
      let(:order) {
        order = Orders::Domain::Order.new(customers_name: "Ben Updated")
        order.id = 1
        return order
      }
      it {
        @under_test.create_order(customers_name: "Ben", status: Orders::Domain::OrderStatus::PENDING)
        subject
        expect(@under_test.get_order(1).customers_name).to eq("Ben Updated")
      }
    end
  end
end
