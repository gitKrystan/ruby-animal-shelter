class Customer
  attr_reader(:id, :first_name, :last_name, :phone, :animal_type_preference, :breed_preference)

  def initialize(arguments)
    @id = arguments[:id]
    @first_name = arguments[:first_name]
    @last_name = arguments[:last_name]
    @phone = arguments[:phone]
    @animal_type_preference = arguments[:animal_type_preference]
    @breed_preference = arguments[:breed_preference]
  end

  def self.all
    results = DB.exec("SELECT * FROM customers;")
    Customer.map_results_to_objects(results)
  end

  def self.map_results_to_objects(results)
    objects = []
    results.each do |result|
      id = result.fetch('id').to_i
      first_name = result.fetch('first_name')
      last_name = result.fetch('last_name')
      phone = result.fetch('phone')
      animal_type_preference = result.fetch('animal_type_preference')
      breed_preference = result.fetch('breed_preference')
      objects << Customer.new({
        :id => id,
        :first_name => first_name,
        :last_name => last_name,
        :phone => phone,
        :animal_type_preference => animal_type_preference,
        :breed_preference => breed_preference})
    end
    objects
  end

  def save
    result = DB.exec("INSERT INTO customers (first_name, last_name, phone, \
      animal_type_preference, breed_preference) VALUES ('#{@first_name}', \
      '#{@last_name}', '#{@phone}', '#{@animal_type_preference}', \
      '#{@breed_preference}') RETURNING id;")
      @id = result.first.fetch('id').to_i()
  end

  def self.sort_by(column)
    results = DB.exec("SELECT * FROM customers ORDER BY #{column};")
    Customer.map_results_to_objects(results)
  end

  def self.filter_by(column, filter)
    results = DB.exec("SELECT * FROM customers WHERE #{column} = '#{filter}';")
    Customer.map_results_to_objects(results)
  end

  def ==(another_customer)
    self.first_name() == another_customer.first_name() &&
    self.last_name() == another_customer.last_name() &&
    self.phone() == another_customer.phone() &&
    self.animal_type_preference() == another_customer.animal_type_preference() &&
    self.breed_preference() == another_customer.breed_preference()
  end

  def animals
    id = @id.to_i
    results = DB.exec("SELECT * FROM animals WHERE customer_id = #{id};")
    Animal.map_results_to_objects(results)
  end

  def self.find(identification)
    Customer.all().each() do |customer|
      if customer.id() == identification
        return customer
      end
    end
    customer = nil
  end
end
