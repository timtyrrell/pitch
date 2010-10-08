Feature: Interactive process control

In order to test interactive command line applications
As a developer using Cucumber
I want to use the interactive session steps

  Scenario: Running ruby interactively
    When I run "ruby /home/tim/apps/pitch/game/start_game.rb" interactively
    Then the output should contain:
    """
    State your bid (2 to 5):
    """
#    And I type "2"
#    Then the output should contain:
#    """
#    test
#    """

