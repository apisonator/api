require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Sessions' do
  post '/api/v1/sessions' do
    example 'Create a session' do
      user = create(:user)
      do_request(user: {email: user.email, password: '12345678'})

      expect(status).to be 201

      api_key = JSON.parse(response_body)['api_key']
      expect(api_key).to be_present
    end

    example 'No registered email' do
      do_request(user: {email: 'invalid@example.com', password: 'lala'})
      expect(status).to be 404

      error = JSON.parse(response_body)['error']
      expect(error).to eq 'not_found'
    end

    example 'Invalid password' do
      user = create(:user)
      do_request(user: {email: user.email, password: 'invalid'})

      expect(status).to be 401

      error = JSON.parse(response_body)['error']
      expect(error).to eq 'unauthorized'
    end

    example 'No user params' do
      user = create(:user)
      do_request()

      expect(status).to be 404

      error = JSON.parse(response_body)['error']
      expect(error).to eq 'not_found'
    end


  end
end
