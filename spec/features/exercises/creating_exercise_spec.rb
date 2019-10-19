require "rails_helper"

RSpec.feature "Creating Exercise" do
    before do
        @john = User.create(email: "john@emaple.com", password: "password")
        login_as(@john)
    end 

    scenario "with valid inputs" do
        visit "/"

        click_link "My Lounge"
        click_link "New Workout"

        expect(page).to have_link("Back")
        
        fill_in "Duration", with: 70
        fill_in "Workout Details", with: "Weight lifting" 
        fill_in "Activity date", with: "2016-07-26"
        click_button "Create Excercise"

        expect(page).to have_content("Exercise has been created")
        
        exercise = Exercise.last
        expect(current_path).to  eq(user_exercises_path(@john, exercises))
        expect(exercise.user_id).to eq(@john.id)
    end

end