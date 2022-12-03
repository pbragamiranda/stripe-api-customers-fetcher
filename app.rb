require_relative "app/repositories/customer_repository"
require_relative "app/controllers/customers_controller"
require_relative "router"

CUSTOMERS_CSV_FILE = File.join(__dir__, "data/customers.csv")

customer_repository = CustomerRepository.new(CUSTOMERS_CSV_FILE)
customers_controller = CustomersController.new(customer_repository)

router = Router.new(customers_controller)
router.run