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
