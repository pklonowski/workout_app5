require 'rails_helper'

RSpec.feature "Deleting Exercise" do
  
  before do
    @owner = User.create(email: "owner@test.com", password: "password")
    @owner_ex = @owner.exercises.create!(duration_in_min: 48, workout: "Body building",
                                         workout_date: Date.today)
    login_as(@owner)
  end

  scenario "with valid data succeeds" do
    visit "/"
    
    click_link "My Lounge"
    
    path = "/users/#{@owner.id}/exercises/#{@owner_ex.id}"
    link = "//a[contains(@href,\'#{path}\') and .//text()='Destroy']"
    find(:xpath, link).click

    expect(page).to have_content("Exercise has been deleted")
  end
end
