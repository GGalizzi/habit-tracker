require 'pry'
require 'capybara/rspec'
require_relative '../spec_helper.rb'

feature "Habit Manager", :type => :feature do
  before(:each) { visit_app_index }
  after(:all) { truncate_json }

  subject { page }

  feature "Home Page" do
    describe "header" do
      it { should have_selector('h1', "Habit Tracker") }
      it { should have_link('New', href: '#/new') }
    end
  end

  feature "Adding a new habit" do
    let(:habitHash) do
      {"values" => { "meditate" => { "name" => "Meditate",
                                     "rewards" => "Improve self-discipline, self-control, self-awareness." ,
                                     "level" => 1,
                                     "points" => 0,
                                     "pointsToLevel" => 500
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
        expect(the_habit("meditate")["pointsToLevel"]).to eq(habit["pointsToLevel"])
      end

      it "adds the habit to the json file" do
        click_button "Save"
        expect(habits_json).to include(habitHash)
      end

      it { click_button "Save"; should have_content(habit["name"]) }
    end
  end
end
