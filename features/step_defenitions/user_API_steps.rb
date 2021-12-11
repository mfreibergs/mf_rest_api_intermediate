Given('The API is working') do
    response = User_API.list_users

    # Error handling
    error_text = "API is not working\n" + response.body
    raise error_text unless response.success?
end

Then('a new user is created') do
    body = user_body_generator

    response = User_API.create_user(body)

    # Error handling
    error_text = "A new user wasn't created\n" + response.body
    raise error_text unless response.success?
end

When('an existing user is selected') do
    response = User_API.list_users
    response_hash = JSON.parse(response.body)

    # Now this existing user can be used for other steps
    @existing_user = response_hash["data"][0]
end

Then('the users {string} is updated') do |value|
    # Should have a step before that creates @existing_user
    time = Time.now.strftime("%Y_%m_%d_%H_%M_%S")
    id = @existing_user["id"]
    body = {value => time}

    response = User_API.update_user(id, body)

    # Error handling
    error_text = "User wasn't updated\n" + response.body
    raise error_text unless response.success?
end

Then('create a new user with the same {string}') do |value|
    # Should have a step before that creates @existing_user
    body = user_body_generator
    body[value] = @existing_user[value]

    response = User_API.create_user(body)

    # Error handling
    error_text = "No error was received\n" + response.body
    raise error_text if response.success?

    error_field = JSON.parse(response.body)["data"][0]["field"]
    error_text = "Wrong error was received\n" + response.body
    raise error_text unless error_field == value
end

Then('remove the user') do
    id = @existing_user["id"]

    response = User_API.delete_user(id)

    # Error handling
    error_text = "Threw and error\n" + response.body
    raise error_text unless response.success?
end

And('remove the user again') do
    id = @existing_user["id"]

    response = User_API.delete_user(id)

    # Error handling
    error_text = "Didn't throw an error\n" + response.body
    raise error_text if response.success?
end