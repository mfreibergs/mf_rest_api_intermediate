def user_body_generator
    time = Time.now.strftime("%Y_%m_%d_%H_%M_%S")

    body = {
        "name" => "John Doe " + time,
        "gender" => "male",
        "email" => "john.doe+#{time}+@gmail.com",
        "status" => "active"
    }
end

