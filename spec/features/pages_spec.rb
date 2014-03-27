require 'capybara/rspec'
require_relative '../spec_helper.rb'

describe "Task Manager", :type => :feature do
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
      it { should have_selector('h1', "Task Tracker") }
      it { should have_link('New', href: '#/new') }
    end
  end

  describe "New task" do
    before { click_link 'New' }

    it { should have_content("New Task") }

    describe "with invalid information" do
      it { should have_button('Save', disabled: true) }
    end

    describe "with valid information" do
      let(:task) { {"values" => { "meditate" => { "name" => "Meditate", "rewards" => "Improve self-discipline, self-control, self-awareness." } } } }
      before do
        fill_in "name",   with: task["values"]["meditate"]["name"]
        fill_in "rewards",with: task["values"]["meditate"]["rewards"]
      end

      it "adds a task" do
        expect { click_button "Save" }.to change{tasks_count}.by(1)
      end

      it "associates the task with the reward" do
        click_button "Save"
        expect(reward_of("meditate")).to eq(task["values"]["meditate"]["rewards"])
      end

      it "adds the task to the json file" do
        click_button "Save"
        #expect json file to have meditate.
        expect(tasks_json).to include(task)
      end

      it { click_button "Save"; should have_content(task["values"]["meditate"]["name"]) }
    end
  end
end
