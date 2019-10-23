require "rails_helper"

RSpec.feature "Listing Exercises" do
    before do
        @owner= User.create!(email: "jack@example.com", password: "password")
        
        @owner_exercise = @owner.exercises.create(duration_in_min: 48, 
                                        workout: "My body buildig activity", 
                                        workout_date: Date.today) 
        login_as(@owner)        
    end  

    scenario do

        visit "/"

        click_link "My Lounge"

        path = "/users/#{@owner.id}/exercises/#{@owner_exercise.id}/"
        link = "//a[contains(#href,\'#{path}\') and .//text()='Destroy']"

        find(:path, link).click

        expect(page).to have_content("Exercise has been deleted")  
    end
end