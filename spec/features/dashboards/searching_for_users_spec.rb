require "rails_helper"

RSpec.feature "Listing Members" do
    before do
        @john = User.create!(first_name: "John", 
                            last_name: "Doe", 
                            email: "john@exampel.com", 
                            password: "password")

        @sarah = User.create!(first_name: "Sarah", 
            last_name: "Doe", 
            email: "sarah@exampel.com", 
            password: "password")               
        login_as(@john)         
    end

    scenario "with existing name returns all those users" do
        visit "/"

        fill_in "search_name",	with: "Doe"
        click_button "Search"
        
        expect(page).to have_content(@john.full_name)
        expect(page).to have_content(@sarah.full_name)
        expect(current_path).to eq("/dashboards/search")      
    end

end