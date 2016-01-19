require "sinatra"
require "sinatra/reloader"
require "./lib/animal"
require "./lib/customer"
require "pg"

DB = PG.connect({:dbname => 'animal_shelter_test'})

get('/') do
  erb(:index)
end

get('/employee') do
  erb(:employee)
end

get('/animals/new') do
  @accepted_animals = Animal.accepted_animals()
  erb(:animal_form)
end
