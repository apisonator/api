require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Releases' do

  before do
    @user = create(:user)
    create(:proxy)

    no_doc do
      client.post '/api/v1/proxies', { api_key: api_key, endpoint: 'http://bar.com', subdomain: 'foo' }
    end
  end

  let(:api_key) {
    @user.api_key
  }

  let(:config) {
    {'subdomain' => 'foo'}.to_yaml
  }

  parameter :api_key, 'API Key', required: true, type: :string
  get '/api/v1/releases' do

    example 'Listing releases' do
      no_doc do
        client.post '/api/v1/releases', { api_key: api_key, config: config }
      end
      do_request
      expect(status).to be 200
    end
  end

  post '/api/v1/releases' do
    parameter :config, 'YAML with the config', required: true, type: :string

    example 'Creating a release' do

      do_request(config: config)

      expect(status).to be 201
    end
  end

  put '/api/v1/releases/:id' do
    parameter :config, 'YAML with the config', required: false, type: :string
    parameter :done, 'Ready to deploy?', required: false, type: :boolean

    example 'Updating a release' do
      no_doc do
        client.post '/api/v1/releases', { api_key: api_key, config: config }
      end

      do_request(config: config, done: true, id: @user.releases.last.id)

      expect(status).to be 204
    end
  end

end
