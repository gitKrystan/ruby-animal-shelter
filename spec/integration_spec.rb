require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding an animal', {:type => :feature}) do
  it('allows an employee to add an animal to the database and view its details') do
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
