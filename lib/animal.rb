class Animal
  attr_reader(:id, :name, :sex, :date_of_admittance, :type, :breed, :customer_id)

  def initialize(arguments)
    @id = arguments[:id]
    @name = arguments[:name]
    @sex = arguments[:sex]
    @date_of_admittance = arguments[:date_of_admittance]
    @type = arguments[:type]
    @breed = arguments[:breed]
    @customer_id = arguments[:customer_id]
  end

  def self.all
    results = DB.exec("SELECT * FROM animals;")
    all_animals = []
    results.each() do |result|
      id = result.fetch('id').to_i()
      name = result.fetch('name')
      sex = result.fetch('sex')
      type = result.fetch('type')
      breed = result.fetch('breed')
      customer_id = result.fetch('customer_id').to_i()
      all_animals << Animal.new({
        :id => id,
        :name => name,
        :sex => sex,
        :type => type,
        :breed => breed,
        :customer_id => customer_id,
        })
    end
    all_animals
  end

  def save
    DB.exec("INSERT INTO animals (name, sex, date_of_admittance, \
      type, breed, customer_id) VALUES ('#{@name}', '#{@sex}', \
      '#{@date_of_admittance}', '#{@type}', '#{@breed}', #{@customer_id});")
  end

  def ==(another_animal)
    self.name() == another_animal.name() &&
    self.sex() == another_animal.sex() &&
    self.type() == another_animal.type() &&
    self.breed() == another_animal.breed() &&
    self.customer_id() == another_animal.customer_id()
  end
end
