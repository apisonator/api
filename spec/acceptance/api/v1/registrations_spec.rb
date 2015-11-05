require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Registrations' do
  post '/api/v1/registrations' do
    example 'Create an account' do
      do_request(user: {email: 'foo@example.com', password: '12345678'})

      expect(status).to be 201

      api_key = JSON.parse(response_body)['api_key']
      expect(api_key).to be_present
    end

    example 'Invalid registration' do
      do_request()

      expect(status).to

      errors = JSON.parse(response_body)['errors']
      expect(errors['email'][0]).to eq "can't be blank"
      expect(errors['password'][0]).to eq "can't be blank"
    end

  end
end
