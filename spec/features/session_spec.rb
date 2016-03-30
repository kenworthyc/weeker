require 'spec_helper'

feature "User logs in to the site" do 
  User.create(first_name: 'Test', last_name: 'App', email:'weekerapp@gmail.com', password:'password')
  scenario "sees the welcome message" do
    visit '/sessions/new'
    fill_in 'email', :with => 'weekerapp@gmail.com'
    fill_in 'Password', :with => 'password'
    click_button 'LOGIN'
    expect(page).to have_content('Welcome')
  end

  scenario "sees an error message if credentials are incorrect" do
    visit '/sessions/new'
    fill_in 'email', :with => 'weekerapp@gmail.com'
    fill_in 'Password', :with => 'test'
    click_button 'LOGIN'
    expect(page).to have_content('Sorry, the credentials provided do not match!')
  end

  scenario "sees a logout link when logged in" do 
    visit '/sessions/new'
    fill_in 'email', :with => 'weekerapp@gmail.com'
    fill_in 'Password', :with => 'password'
    click_button 'LOGIN'
    expect(page).to have_css('.logout')
  end
  
  scenario "clicking logout logs the user out" do 
    visit '/sessions/new'
    fill_in 'email', :with => 'weekerapp@gmail.com'
    fill_in 'Password', :with => 'password'
    click_button 'LOGIN'
    click_button 'logout'
    expect(page).to have_content('Login')
  end
end
