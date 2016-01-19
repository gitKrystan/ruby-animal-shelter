require "rspec"
require "pg"
require "animal"
require "customer"
require "pry"

DB = PG.connect({:dbname => 'animal_shelter_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM animals *;")
    DB.exec("DELETE FROM customers *;")
  end
end

def create_test_customer
  Customer.new({
    :id => nil,
    :first_name => "Alex",
    :last_name => "Smith",
    :phone => "555-555-5555",
    :animal_type_preference => "cat",
    :breed_preference => "Maine Coon"})
end

def create_test_animal
  Animal.new({
    :id => nil,
    :name => "Harry Princess",
    :sex => "M",
    :date_of_admittance => '2016-01-01',
    :type => "cat",
    :breed => "Maine Coon",
    :customer_id => 1,
    })
end

def create_second_test_animal
  Animal.new({
    :id => nil,
    :name => "Snoopy",
    :sex => "F",
    :date_of_admittance => '2015-11-11',
    :type => "dog",
    :breed => "Beagle",
    :customer_id => 2,
    })
end
