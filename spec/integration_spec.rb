require('capybara/rspec')
require('./app')
require('./spec/spec_helper')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding an animal', {:type => :feature}) do
  it('allows an employee to add an animal to the database') do
    visit('/')
    click_link('An Employee')
    click_link('Add an Animal')
    fill_in('name', :with => 'Fluffytail')
    choose('M')
    fill_in('date_of_admittance', :with => '2015-12-13')
    select('dog')
    fill_in('breed', :with => 'pug')
    click_button('Add')
    expect(page).to(have_content('Fluffytail'))
  end
end

describe('viewing an animal', {:type => :feature}) do
  it("allows a user to view an animal's details") do
    create_test_animal(0).save()
    visit('/')
    click_link('An Employee')
    click_link('View Animals')
    click_link('Harry Princess')
    expect(page).to(have_content('Harry Princess'))
    expect(page).to(have_content('Maine Coon'))
  end
end

describe('adding a customer', {:type => :feature} ) do
  it('allow an employee to add a customer') do
    visit('/')
    click_link('An Employee')
    click_link('Add a Customer')
    fill_in('first_name', :with => 'Bob')
    fill_in('last_name', :with => 'Cobb')
    fill_in('phone', :with => '555-555-5555')
    select('cat')
    fill_in('breed', :with => 'Maine Coon')
    click_button('Add')
    expect(page).to(have_content('Bob'))
  end
end

describe('viewing a customer', {:type => :feature}) do
  it("allows an employee to view a customer's details") do
    create_test_customer.save()
    visit('/')
    click_link('An Employee')
    click_link('View Customers')
    click_link('Alex Smith')
    expect(page).to(have_content('Alex Smith'))
    expect(page).to(have_content('Maine Coon'))
  end
end
