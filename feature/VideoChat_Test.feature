Feature: VideoChat_Screenshot
  As a video chat user, I would like the ability to take screenshots during a video chat

  Scenario: VideoChat_Screenshot_Validate user can take multiple screenshots
    Given 1 dynamic admin user created
    And video chat enabled for dynamic practice
    And dynamic user 1 is logged into webapp
    And I click the video chat button
    And I click the create link button
    Then Contact joins room using the link
    Given I am in an active video chat
    When I click and take 3 screenshots
    Then I see my screenshot on the video chat sidebar
    And The total screenshot amount is 3
