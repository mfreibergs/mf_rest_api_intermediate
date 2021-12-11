Feature: User API tests
    Test the API calls that affect the user  

    Background: 
        Given The API is working

    Scenario: Create a user (positive)
        Then a new user is created

    Scenario: Update users value (positive)
        When an existing user is selected
        Then the users <value> is updated
    Examples:
        | value    |
        | "name"   | 

    Scenario: Create a user (negative)
        When an existing user is selected
        Then create a new user with the same <value>
    Examples:
        | value    |
        | "email"  | 

    Scenario: Remove a user (negative)
        When an existing user is selected
        Then remove the user
        And remove the user again

