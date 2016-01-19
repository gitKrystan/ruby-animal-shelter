require "sinatra"
require "sinatra/reloader"
require "./lib/animal"
require "./lib/customer"
require "pg"
require "pry"

DB = PG.connect({:dbname => 'animal_shelter_test'})

get('/') do
  erb(:index)
end

get('/employee') do
  erb(:employee)
end

get('/animals') do
  @animals = Animal.all()
  erb(:animals)
end

get('/animals/new') do
  @accepted_animals = Animal.accepted_animals()
  erb(:animal_form)
end

post('/animals/new') do
  name = params[:name]
  sex = params[:sex]
  date_of_admittance = params[:date_of_admittance]
  type = params[:type]
  breed = params[:breed]
  new_animal = Animal.new({
    :id => nil,
    :name => name,
    :sex => sex,
    :date_of_admittance => date_of_admittance,
    :type => type,
    :breed => breed,
    :customer_id => 'NULL'
    })
  new_animal.save()
  redirect('/animals')
end

get('/animals/:id') do
  @id = params[:id].to_i()
  @animal = Animal.find(@id)
  erb(:animal)
end

get('/customers') do
  @customers = Customer.all()
  erb(:customers)
end

get('/customers/new') do
  @accepted_animals = Animal.accepted_animals()
  erb(:customer_form)
end

post('/customers/new') do
  first_name = params[:first_name]
  last_name = params[:last_name]
  phone = params[:phone]
  type = params[:type]
  breed = params[:breed]
  new_customer = Customer.new({
    :id => nil,
    :first_name => first_name,
    :last_name => last_name,
    :phone => phone,
    :type => type,
    :breed => breed,
    })
  new_customer.save()
  redirect('/customers')
end
