require "rails_helper"

RSpec.feature 'Dollowing Firends' do
    before do
        @john = User.create(email: "john@example.com", password: "password", first_name: "John", 
            last_name: "Doe")

        @peter = User.create(email: "peter@example.com", password: "password", first_name: "Peter", 
            last_name: "Yum")    
        login_as(@john)
    end

    scenario "if signed in" do
        visit '/'

        expect(page).to have_content(@john.full_name)
        expect(page).to have_content(@peter.full_name)
        
        href = "/friendships?friend_id=#{@john.id}"
        expect(page).not_to have_link("Follow", :href => href)

        link = "a[href='/friendships?friend_id=#{@peter.id}']"
        find(link).click

        href = "/friendships?friend_id=#{@peter.id}"
        expect(page).not_to have_link("Follow", :href => href)
    end
end