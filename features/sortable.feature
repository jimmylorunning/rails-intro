Feature: Movies should be sortable
  In order to ease movie browsing
  Movie fans
  Should be able to see movies organized by title or release date

Scenario: Movies can be sorted by title
	Given I am at the home page
	When I click the Movie Title link
	Then movie titles should be listed in alphabetical order