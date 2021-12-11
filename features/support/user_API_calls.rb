require 'faraday'
require 'json'

module User_API
    @auth_token = File.read("auth_token.txt")
    @url = "https://gorest.co.in/public/v1/users/"

    def self.list_users
        response = Faraday.get(@url, {'access-token': @auth_token})
    end

    def self.create_user(body)
        response = Faraday.post(@url) do |req|
            req.params['access-token'] = @auth_token
            req.headers['Content-Type'] = 'application/json'
            req.body = body.to_json
        end
    end

    def self.update_user(id, body)
        response = Faraday.patch(@url+id.to_s) do |req|
            req.params['access-token'] = @auth_token
            req.headers['Content-Type'] = 'application/json'
            req.body = body.to_json
        end
    end

    def self.delete_user(id)
        response = Faraday.delete(@url+id.to_s, {'access-token': @auth_token})
    end
end