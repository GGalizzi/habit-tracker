require 'capybara/rspec'
require_relative '../spec_helper.rb'

feature "Habit List", :type => :feature do
    before { populate_json }

    it "should contain some habits" do
      page.should have_content("Meditate")
      page.should have_content("Program")
      page.should have_content("Exercise")
    end

    it "should contain delete and edit" do
      page.should have_button("delete")
      page.should have_button("edit")
    end

    describe "delete function" do
      it "should show a confirmation" do
        click_button "delete-meditate"
        page.should have_content("confirm")
      end

      it "canceling the deletion should avoid it" do
        click_button "delete-meditate"
        page.should have_content("cancel")
        click_button("cancel")
        page.should have_content("Meditate")
      end

      it "should delete the habit after confirming" do
        click_button "delete-meditate"
        expect{click_button "confirm"}.to change{habits_count}.by(-1);
        page.should_not have_content("Error")
        page.should_not have_content("Meditate")
      end
    end

    describe "edit function" do
      it "should allow editing of name" do
        click_button "edit-meditate"
        page.should have_selector('input')
        page.should_not have_selector("span", text: "Meditate")
        fill_in "name", with: "Mindfulness"
        click_button "confirm"
        page.should have_selector('span', text: "Mindfulness")
        expect(the_habit("mindfulness")["name"]).to eq("Mindfulness")
      end

      it "should allow cancelling the edit" do
        click_button "edit-meditate"
        fill_in "name", with: "Chuck Norris it"
        click_button "cancel"
        page.should have_selector('span', text: "Meditate")
        page.should_not have_content("Chuck Norris it")
      end

      it "should not allow editing more than one at a time" do
        click_button "edit-meditate"
        page.should_not have_button("edit-program")
      end
    end
end
