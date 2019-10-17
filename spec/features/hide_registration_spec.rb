require "rails_helper"

RSpec.feature "Hide Sign in and Sing up" do
    before do
        @user = User.create(email: "jack@example.com", password: "password")
        login_as(@user)
    end

    scenario do
        visit "/"

        expect(page).not_to have_link("Sign in")
        expect(page).not_to have_link("Sign up")
        expect(page).to  have_link("Log out") 
        expect(page).to  have_content("Signed in as #{@user.email}") 
    end
end