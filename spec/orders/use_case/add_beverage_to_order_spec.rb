require 'rspec'
require 'orders/use_case/add_beverage_to_order'
require 'orders/gateway/order'
require 'orders/domain/order'
require 'coffee'

describe Orders::UseCase::AddBeverageToOrder do
  before do
    @gateway = instance_double(Orders::Gateway::Order)
  end

  context 'when adding a beverage to a customer order' do
    subject do
      described_class.new(gateway: @gateway).add_beverage_to_order(request)
    end

    context 'when cannot find order' do
      let(:request) { Orders::UseCase::AddBeverageToOrder::Request.new('1', Coffee.new) }
      it {
        expect(@gateway).to receive(:get_order).and_return(nil)
        expect{subject}.to raise_error(OrderError)
      }
    end

    context 'when adding an empty beverage to order' do
      let(:request) { Orders::UseCase::AddBeverageToOrder::Request.new('1', nil) }
      it {
        expect{subject}.to raise_error(InvalidBeverageError)
      }
    end

    context 'when adding an invalid beverage to order' do
      let(:request) { Orders::UseCase::AddBeverageToOrder::Request.new('1', "invalid beverage") }
      it {
        expect{subject}.to raise_error(InvalidBeverageError)
      }
    end

    context 'when adding a beverage to order' do
      let(:request) { Orders::UseCase::AddBeverageToOrder::Request.new('1', Coffee.new) }
      it {
        order = Orders::Domain::Order.new(customers_name: "Ben")
        expect(@gateway).to receive(:get_order).with(1).and_return(order)
        is_expected{
          expect(order.beverages.length).to eq(1)
          expect(order.beverages.length[0]).to eq(Coffee.new)
        }
      }
    end
  end
end
