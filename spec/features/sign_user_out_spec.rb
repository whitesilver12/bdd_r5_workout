require "rails_helper"

RSpec.feature "Sign out User" do
    before do
        @john = User.create!(email: "jack@example.com", password: "password", first_name: "John", 
                            last_name: "Doe")
        # login_as(@john)

        visit '/'
        click_link "Sign in"
        fill_in "Email", with: "jack@example.com" 
        fill_in "Password",	with: "password" 
        click_button "Log in"
    end

    scenario do
        visit "/"

        click_link "Log out"
        expect(page).to  have_content("Signed out successfully.")
    end

end