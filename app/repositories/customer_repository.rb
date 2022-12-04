# frozen_string_literal: true

require 'csv'
require_relative '../models/customer'

class CustomerRepository
  def initialize(csv_filepath)
    @csv_filepath = csv_filepath
    @customers = []
    load_csv if File.exist?(@csv_filepath)
  end

  def all
    @customers
  end

  def create_customers(customers, quantity)
    quantity.is_a?(Integer) ? create_n_customers(customers, quantity) : create_all_customers(customers)
    save_csv
  end

  private

  def create_all_customers(customers)
    customers.auto_paging_each do |customer|
      new_customer = build_customer(customer)
      @customers <<  new_customer
    end
  end

  def create_n_customers(customers, quantity)
    customers.first(quantity).each do |customer|
      new_customer = build_customer(customer)
      @customers <<  new_customer unless user_already_saved_in_csv?(customer.id)
    end
  end

  def user_already_saved_in_csv?(id)
    @customers.find { |customer| customer.id == id }
  end

  def build_customer(customer)
    Customer.new(id: customer['id'],
                 name: customer['name'],
                 email: customer['email'],
                 account_balance: customer['account_balance'],
                 default_currency: customer['default_currency'])
  end

  def build_customer_array(customer)
    [
      customer.id,
      customer.name,
      customer.email,
      customer.account_balance,
      customer.default_currency
    ]
  end

  def save_csv
    CSV.open(@csv_filepath, 'wb') do |csv|
      csv << %w[customer_id name email account_balance default_currency]
      @customers.each do |customer|
        csv << build_customer_array(customer)
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_filepath, headers: :first_row, header_converters: :symbol) do |row|
      row[:account_balance] = row[:account_balance].to_f
      @customers << Customer.new(row)
    end
  end
end
