require 'pry'
require 'capybara/rspec'
require_relative '../spec_helper.rb'

feature "Habit Manager", :type => :feature do
  before(:each) { visit_app_index }
  after(:each) { truncate_json }

  subject { page }

  feature "Home Page" do
    describe "header" do
      it { should have_selector('h1', "Habit Tracker") }
      it { should have_link('New', href: '#/new') }
    end

    describe "Habit List" do
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
  end

  feature "Adding a new habit" do
    let(:habitHash) do
      {"values" => { "meditate" => { "name" => "Meditate",
                                     "rewards" => "Improve self-discipline, self-control, self-awareness." ,
                                     "level" => 1,
                                     "points" => 0
      }}}
    end

    let(:habit) { habitHash["values"]["meditate"] }
    before { click_link 'New' }

    it { should have_content("New Habit") }

    describe "with invalid information" do
      it { should have_button('Save', disabled: true) }

      describe "identical habit name" do
        before do
          fill_in "name",   with: habit["name"]
          fill_in "rewards",with: habit["rewards"]
          click_button "Save"
          click_link "New"
          fill_in "name",   with: habit["name"]
          fill_in "rewards",with: "bananas"
        end

        it "should mention habit is already added" do
          page.should have_button "Save", disabled: true
          page.should have_content "This habit is already registered."
        end
        it "should count 1 habit" do
          expect(habit_count).to eq(1)
        end
      end
    end

    describe "with valid information" do


      before do
        fill_in "name",   with: habit["name"]
        fill_in "rewards",with: habit["rewards"]
      end

      it "should not contain errors" do
        page.should_not have_selector('div.error')
        page.should_not have_selector('span.error')
      end

      it "adds a habit" do
        expect { click_button "Save" }.to change{habits_count}.by(1)
      end

      it "associates the habit with the reward" do
        click_button "Save"
        expect(the_habit("meditate")["rewards"]).to eq(habit["rewards"])
      end

      it "starts the habit at level 1" do
        click_button "Save"
        expect(the_habit("meditate")["level"]).to eq(habit["level"])
      end

      it "adds the habit to the json file" do
        click_button "Save"
        expect(habits_json).to include(habitHash)
      end

      it { click_button "Save"; should have_content(habit["name"]) }
    end
  end

  feature "leveling system" do
    before { populate_json }

    describe "when the points are enough, level " do
      it "should receive 240 experience per completion" do
        click_button "success-meditate"
        expect(the_habit("meditate")["points"]).to eq(240)
      end

      it "should level up when enough experience is reached" do
        5.times { click_button "success-meditate" }
        expect(the_habit("meditate")["level"]).to eq(2)
        11.times { click_button "success-meditate" }
        expect(the_habit("meditate")["level"]).to eq(4)
      end
    end
  end
end
