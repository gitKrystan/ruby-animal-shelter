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
