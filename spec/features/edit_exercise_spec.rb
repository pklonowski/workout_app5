require 'rails_helper'

RSpec.feature "Editing Exercise" do
  
  before do
    @owner = User.create(email: "owner@test.com", password: "password")
    @owner_ex = @owner.exercises.create!(duration_in_min: 48, workout: "Body building",
                                         workout_date: Date.today)
    login_as(@owner)
  end

  scenario "with valid data succeeds" do
    visit "/"
    
    click_link "My Lounge"
    
    path = "/users/#{@owner.id}/exercises/#{@owner_ex.id}/edit"
    link = "a[href=\'#{path}\']"
    find(link).click
    
    fill_in "Duration", with: 45
    click_button "Update Exercise"
    
    expect(page).to have_content("Exercise has been updated")
    expect(page).to have_content(45)
    expect(page).not_to have_content(48)
  end
end