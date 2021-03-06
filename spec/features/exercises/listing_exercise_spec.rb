require "rails_helper"

RSpec.feature "Listing Exercises" do
    before do
        @john = User.create(email: "john@example.com", password: "password", first_name: "John", 
                            last_name: "Doe")

        @sarah = User.create(email: "sarah@example.com", password: "password", first_name: "Sarah", 
        last_name: "Anderson")

        login_as(@john)

        @e1 = @john.exercises.create(duration_in_min: 20, 
                                        workout: "My body buildig activity", 
                                        workout_date: Date.today) 

        @e2 = @john.exercises.create(duration_in_min: 55, 
                                        workout: "Weight lifting", 
                                        workout_date: 2.days.ago)  

        @following = Friendship.create(user: @john, friend: @sarah)                                
                                        
        # @e3 = @john.exercises.create(duration_in_min: 35, 
        #                                 workout: "On treadmill", 
        #                                 workout_date: 8.days.ago)                                   
    end

    scenario "shows user's workout for last 7 days" do
        visit "/"

        click_on 'My Lounge'

        expect(page).to have_content(@e1.duration_in_min)  
        expect(page).to have_content(@e1.workout)  
        expect(page).to have_content(@e1.workout_date)  

        expect(page).to have_content(@e2.duration_in_min)  
        expect(page).to have_content(@e2.workout)  
        expect(page).to have_content(@e2.workout_date)  

        # expect(page).not_to have_content(@e3.duration_in_min)  
        # expect(page).not_to have_content(@e3.workout)  
        # expect(page).not_to have_content(@e3.workout_date)  

    end

    scenario "shows no exercises if none created" do
        @john.exercises.delete_all

        visit "/"

        click_link "My Lounge"
        expect(page).to have_content("No workouts Yet")  
    end

    scenario "shows a list of users friends" do
        visit "/"

        click_link "My Lounge"
        expect(page).to have_content("My friends")
        expect(page).to have_content(@sarah.full_name)
        expect(page).to have_link("Unfollow")      
    end
end