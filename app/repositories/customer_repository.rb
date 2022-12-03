require "csv"
require_relative "../models/customer"

class CustomerRepository
  def initialize(csv_filepath)
    @csv_filepath = csv_filepath
    @customers = []
    load_csv if File.exist?(@csv_filepath)
  end

  def create_customers(customers, quantity)
    if quantity.is_a?(Integer)
      customers.each do |customer|
        new_customer = build_customer(customer) 
        @customers <<  new_customer unless user_already_saved_to_csv?(customer.id)    
      end
    else
      customers.auto_paging_each do |customer|
        new_customer = build_customer(customer) 
        @customers <<  new_customer     
      end
    end
    save_csv
  end

  def all
    @customers
  end

  def user_already_saved_to_csv?(id)
    @customers.find { |customer| customer.id == id  }
  end

  private

  def save_csv
    CSV.open(@csv_filepath, "wb") do |csv|
      csv << ["id", "name", "email", "account_balance", "default_currency"]
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

  def build_customer(customer)
    Customer.new(id: customer["id"], 
                    name: customer["name"], 
                    email: customer["email"], 
                    account_balance: customer["account_balance"],
                    default_currency: customer["default_currency"]
                    )
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

end
