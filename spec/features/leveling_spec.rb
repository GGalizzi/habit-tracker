require 'pry'
require 'capybara/rspec'
require_relative '../spec_helper.rb'

feature "leveling system", :type => :feature do
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
