class Animal
  attr_reader(:id, :name, :sex, :date_of_admittance, :type, :breed, :customer_id)

  @@accepted_animals = ['cat', 'dog', 'rabbit', 'turtle']

  def initialize(arguments)
    @id = arguments[:id]
    @name = arguments[:name]
    @sex = arguments[:sex]
    @date_of_admittance = arguments[:date_of_admittance]
    @type = arguments[:type]
    @breed = arguments[:breed]
    @customer_id = arguments[:customer_id]
  end

  def self.accepted_animals
    @@accepted_animals
  end

  def self.all
    results = DB.exec("SELECT * FROM animals;")
    Animal.map_results_to_objects(results)
  end

  def save
    result = DB.exec("INSERT INTO animals (name, sex, date_of_admittance, \
      type, breed, customer_id) VALUES ('#{@name}', '#{@sex}', \
      '#{@date_of_admittance}', '#{@type}', '#{@breed}', #{@customer_id}) RETURNING id;")
    @id = result.first.fetch('id').to_i()
  end

  def ==(another_animal)
    self.name() == another_animal.name() &&
    self.sex() == another_animal.sex() &&
    self.type() == another_animal.type() &&
    self.breed() == another_animal.breed() &&
    self.customer_id() == another_animal.customer_id()
  end

  def self.map_results_to_objects(results)
    objects = []
    results.each() do |result|
      id = result.fetch('id').to_i()
      name = result.fetch('name')
      sex = result.fetch('sex')
      date_of_admittance = result.fetch('date_of_admittance')
      type = result.fetch('type')
      breed = result.fetch('breed')
      customer_id = result.fetch('customer_id').to_i()
      objects << Animal.new({
        :id => id,
        :name => name,
        :sex => sex,
        :date_of_admittance => date_of_admittance,
        :type => type,
        :breed => breed,
        :customer_id => customer_id,
        })
    end
    objects
  end

  def self.sort_by(column)
    results = DB.exec("SELECT * FROM animals ORDER BY #{column};")
    Animal.map_results_to_objects(results)
  end

  def self.filter_by(column, filter)
    results = DB.exec("SELECT * FROM animals WHERE #{column} = '#{filter}';")
    Animal.map_results_to_objects(results)
  end
end
