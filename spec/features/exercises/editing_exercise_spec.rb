require "rails_helper"

RSpec.feature "Listing Exercises" do
    before do
        @owner= User.create!(email: "jack@example.com", password: "password", first_name: "Jack", last_name: "Doe")
        
        @owner_exercise = @owner.exercises.create(duration_in_min: 48, 
                                        workout: "My body buildig activity", 
                                        workout_date: Date.today) 
        login_as(@owner)        
    end     

    scenario "with valid date success" do
        visit "/"

        click_link "My Lounge"

        path = "/users/#{@owner.id}/exercises/#{@owner_exercise.id}/edit"
        link = "a[href=\'#{path}\']"
        find(link).click

        fill_in "Duration", with: 45
        click_button "Update Exercise"

        expect(page).to have_content("Exercise has been updated")
        expect(page).to have_content(45)   
        expect(page).not_to have_content(48)
    end
end                           
