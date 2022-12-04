# frozen_string_literal: true

require_relative '../../router'
require_relative '../../app/models/customer'
require_relative '../../app/controllers/customers_controller'
require_relative '../../app/repositories/customer_repository'
require_relative '../../app/services/stripe_customers_fetcher'

describe 'User Actions', :user_actions do
  let(:stripe_api_key) { 'your_stripe_api_key' }
  let(:csv_path) { 'spec/support/customers.csv' }
  let(:customers_repository) { CustomerRepository.new(csv_path) }
  let(:customers_controller) { CustomersController.new(customers_repository) }

  before(:each) do
    customers_controller.download_customers(stripe_api_key, quantity: 50)
  end

  after(:each) do
    File.truncate(csv_path, 0)
  end

  describe '#download_customers' do
    it 'should allow users to download 50 customers' do
      number_of_customers = customers_repository.all.count
      expect(number_of_customers).to eq(50)
    end
  end

  describe '#count_customers' do
    it 'should allow users to see number of customers downloaded' do
      number_of_customers = customers_repository.all.count
      expect($stdout).to receive(:puts).with("You currently have #{number_of_customers} customers")
      customers_controller.count_customers
    end
  end
end
