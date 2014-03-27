require 'capybara/rspec'
require_relative '../spec_helper.rb'

describe "Habit Manager", :type => :feature do
  before(:each) { visit_app_index }
  after(:all) { truncate_json }

=begin
  after(:all) do
    visit_app_index
    click_link 'Close'
  end
=end

  subject { page }

  describe "Home Page" do
    describe "header" do
      it { should have_selector('h1', "Habit Tracker") }
      it { should have_link('New', href: '#/new') }
    end
  end

  describe "New habit" do
    before { click_link 'New' }

    it { should have_content("New Habit") }

    describe "with invalid information" do
      it { should have_button('Save', disabled: true) }
    end

    describe "with valid information" do
      let(:habit) do
        {"values" => { "meditate" => { "name" => "Meditate",
                                                  "rewards" => "Improve self-discipline, self-control, self-awareness." 
        }}}
      end
      before do
        fill_in "name",   with: habit["values"]["meditate"]["name"]
        fill_in "rewards",with: habit["values"]["meditate"]["rewards"]
      end

      it "adds a habit" do
        expect { click_button "Save" }.to change{habits_count}.by(1)
      end

      it "associates the habit with the reward" do
        click_button "Save"
        expect(reward_of("meditate")).to eq(habit["values"]["meditate"]["rewards"])
      end

      it "starts the habit at level 1" do
        click_button "Save"
      end

      it "adds the habit to the json file" do
        click_button "Save"
        #expect json file to have meditate.
        expect(habits_json).to include(habit)
      end

      it { click_button "Save"; should have_content(habit["values"]["meditate"]["name"]) }
    end
  end
end
