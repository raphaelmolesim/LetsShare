Feature: Connect with facebook

  Scenario: Connect with facebook
    Given an user not registered that wants to connect with a faceboook account
	And with username "raphael.sm86@gmail.com"
	And password "PASSWORD"
    When he click in connect
    Then I should connect him to the facebook