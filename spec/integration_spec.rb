require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding an animal', {:type => :feature}) do
  # it('allows a worker to add an animal to the database and view its details') do
  #   visit('/')
  #   click_link('Employee')
  #   click_link('Add an Animal')
  #   fill_in('name', :with => 'Fluffytail')
  #   choose('M')
  #   fill_in('date_of_admittance', :with => '2015-12-13')
  #   fill_in('type', :with => 'dog')
  #   fill_in('breed', :with => 'pug')
  #   click_button('Add')
  #   expect(page).to(have_content('Fluffytail'))
  # end
end
