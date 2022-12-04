# frozen_string_literal: true

require_relative '../../app/models/customer'

describe 'Customer', :customer do
  it 'should be initialized with a hash of properties' do
    properties = { id: 'cus_Mv4Yf58uU98h2n', name: 'Pele', email: 'pele@brazil.com' }
    customer = Customer.new(properties)
    expect(customer).to be_a(Customer)
  end

  describe '#id' do
    it 'should return the customer id' do
      customer = Customer.new({ id: 'cus_Mv4Yf58uU98h2n' })
      expect(customer.id).to eq('cus_Mv4Yf58uU98h2n')
    end
  end

  describe '#name' do
    it 'should return the name of the Customer' do
      customer = Customer.new({ name: 'Pele' })
      expect(customer.name).to eq('Pele')
    end
  end

  describe '#email' do
    it 'should return the email of the Customer' do
      customer = Customer.new({ email: 'pele@brazil.com' })
      expect(customer.email).to eq('pele@brazil.com')
    end
  end
end
