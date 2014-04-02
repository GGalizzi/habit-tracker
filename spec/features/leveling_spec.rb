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
      5.times { click_button "success-program" }
      expect(the_habit("program")["level"]).to eq(2)
    end
  end

  describe "failing reduces experience" do
    before { 20.times { click_button "success-meditate" } }
    it "should receive a penalty of 300 points" do
      expect { click_button "fail-meditate" }.to change{ the_habit("meditate")["points"] }.by(-300)
    end

    it "should reduce the habit level when enough fails are gotten" do
      expect { 5.times { click_button "fail-meditate" } }.to change{ the_habit("meditate")["level"]}.by_at_least(-1)
    end

    it "should not go below level 1" do
      10.times { click_button "fail-meditate" }
      expect { click_button "fail-meditate" }.not_to change{ the_habit("meditate")["level"] }
    end
  end
end
