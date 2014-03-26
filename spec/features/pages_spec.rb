require 'capybara/rspec'
require_relative '../spec_helper.rb'

describe "Task Manager", :type => :feature do
  before(:each) { visit_app_index }

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
      before do
        fill_in "name",   with: "Meditate"
      end

      it "should add a task" do
        expect { click_button "Save" }.to change{tasks_count}.by(1)
      end
      it { click_button "Save"; should have_content("Meditate") }
    end
  end
end
