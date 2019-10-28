require "rails_helper"

RSpec.feature "Sign in user" do
    before do
        @john = User.create!(email: "jack@example.com", password: "password", first_name: "John", 
                            last_name: "Doe")
    end

    scenario do
        visit "/"

        click_link "Sign in"
        fill_in "Email", with: @john.email
        fill_in "Password",	with: @john.password
        click_button "Log in"
        expect(page).to  have_content("Signed in successfully.") 
        expect(page).to  have_content("Signed in as #{@john.email}") 
    end

end