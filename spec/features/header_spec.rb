require 'capybara/rspec'
require_relative '../spec_helper.rb'

feature "Home Page", :type => :feature do
  subject { page }
    describe "header" do
      it { should have_selector('h1', "Habit Tracker") }
      it { should have_link('New', href: '#/new') }
    end
end
