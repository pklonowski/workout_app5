require 'rails_helper'

RSpec.feature "Showing Friend Exercise" do
  before do
    @john = User.create(first_name: "John", last_name: "Doe",
                        email: "john@test.com", password: "password")
    
    @sarah = User.create(first_name: "Sarah", last_name: "Anderson",
                        email: "sarah@test.com", password: "password")

    @e1 = @john.exercises.create(duration_in_min: 28,
                                 workout: "Body building",
                                 workout_date: Date.today)

    @e2 = @sarah.exercises.create(duration_in_min: 35,
                                 workout: "Treadmill",
                                 workout_date: Date.today)
                                 
    login_as(@john)

    @following = Friendship.create(user: @john, friend: @sarah)
  end

  scenario "shows friend's workout for last 7 days" do
    visit "/"
    
    click_link "My Lounge"
    click_link @sarah.full_name
    
    expect(page).to have_content(@sarah.full_name + "'s Exercises")
    expect(page).to have_content(@e2.workout)
    expect(page).to have_css("div#chart")
  end
  
end