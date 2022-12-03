class CustomersView
  def display(customers)
    puts "id                 | name                       | email"
    customers.each do |customer|
      puts "#{customer.id} | #{customer.name} | #{customer.email}"
    end
  end

  def display_number_of_customers(number_of_customers)
    puts "You currently have #{number_of_customers} customers"
  end

  def successful_message
    puts "Customers downloaded successfully."
  end
end
