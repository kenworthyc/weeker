require 'spec_helper'

feature "User visits website" do
  scenario "sees the main page" do
    visit '/'
    expect(page).to have_content('Weeker')
  end
end

feature "User is redirected to their user page upon login" do
  User.create(first_name: 'First', last_name: 'Last', email:'firstlast@gmail.com', password:'password')
  scenario "sees the welcome message" do
    visit '/sessions/new'
    fill_in 'email', :with => 'firstlast@gmail.com'
    fill_in 'Password', :with => 'password'
    click_button 'LOGIN'
    expect(page).to have_content('First')
  end
end
