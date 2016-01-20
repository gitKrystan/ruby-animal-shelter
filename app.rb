require "sinatra"
require "sinatra/reloader"
require "./lib/animal"
require "./lib/customer"
require "pg"
require "pry"

DB = PG.connect({:dbname => 'animal_shelter'})

get('/') do
  erb(:index)
end

get('/employee') do
  erb(:employee)
end

# get('/customer-login') do
#   erb(:customer_login)
# end
#
# post('/customer-login') do
#   input_id = params[:id].to_i()
#   if Customer.find(input_id).nil?
#     redirect('/')
#   else
#     redirect("/customers/#{input_id}/animals")
#   end
# end

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
  @customer = Customer.find(@animal.customer_id())
  erb(:animal)
end

get('/animals/:id/adopt') do
  @id = params[:id].to_i()
  @animal = Animal.find(@id)
  erb(:adoption_form)
end

post('/animals/:id/adopt') do
  customer_id = params[:customer_id]
  id = params[:id].to_i()
  animal_before_adoption = Animal.find(id)
  animal_before_adoption.update('customer_id', customer_id)
  animal_after_adoption = Animal.find(id)
  redirect("animals/#{id}")
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
    :animal_type_preference => type,
    :breed_preference => breed,
    })
  new_customer.save()
  redirect('/customers')
end

get('/customers/:id') do
  @id = params[:id].to_i()
  @customer = Customer.find(@id)
  erb(:customer)
end

# get('/customers/:customer_id/animals') do
#   @animals = Animal.all()
#   erb(:animals)
# end
#
# post('/customers/:customer_id/animals/:id') do
#   @id = params[:id].to_i()
#   @animal = Animal.find(@id)
#   @animal.update('customer_id', @customer_id)
#   erb(:animal_adopted)
# end
