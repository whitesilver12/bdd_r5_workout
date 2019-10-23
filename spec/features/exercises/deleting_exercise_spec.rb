require "rails_helper"

RSpec.feature "Delete Exercises" do
    before do
        @owner= User.create!(email: "jack@example.com", password: "password", first_name: "Jack", last_name: "Doe")
        
        @owner_exercise = @owner.exercises.create!(duration_in_min: 48, 
                                        workout: "My body buildig activity", 
                                        workout_date: Date.today) 
        login_as(@owner)        
    end  

    scenario do

        visit "/"

        click_link "My Lounge"

        # link = "a[href='/users/#{@owner.id}/exercises/#{@owner_exercise.id}'][data-method='delete']"
        # find(link).click

        # click_link "Destroy"

        link = "//a[contains(@href,'/users/#{@owner.id}/exercises/#{@owner_exercise.id}') and .//text()='Destroy']"
        find(:xpath, link).click

        expect(page).to have_content("Exercise has been deleted")  
    end
end