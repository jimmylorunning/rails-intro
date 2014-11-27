When(/^I visit the home page$/) do
	visit movies_path
end

Then(/^I should see the home page$/) do
	expect(page).to have_title("Rotten Potatoes!")
	expect(page).to have_xpath("//a[@id='title_header']")
	expect(page).to have_xpath("//a[@id='release_date_header']")
	expect(page).to have_xpath("//table[@id='movies']")
end

Given(/^I am at the home page$/) do
  visit movies_path
end

When(/^I click the Movie Title link$/) do
  click_link('title_header')
end

Then(/^movie titles should be listed in alphabetical order$/) do
  pending # don't know how to do this!
end