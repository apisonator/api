require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Proxies" do

  before do
    @user = create(:user)
  end

  let(:api_key) {
    @user.api_key
  }

  parameter :api_key, 'API Key', required: true, type: :string

  get "/api/v1/proxies" do

    example "Listing proxies", document: :v1 do
      no_doc do
        client.post '/api/v1/proxies', { api_key: api_key, endpoint: 'http://bar.com' }
        client.post '/api/v1/proxies', { api_key: api_key, endpoint: 'http://bar.com' }
        client.post '/api/v1/proxies', { api_key: api_key, endpoint: 'http://bar.com' }
      end

      do_request

      expect(status).to be 200
    end
  end

  post "/api/v1/proxies.json" do
    parameter :endpoint, 'URL to proxy', required: true, type: :string
    parameter :subdomain, 'Subdomain for the proxy', required: false, type: :string

    example "Creating a proxy" do
      do_request(endpoint: 'http://foo.bar', subdomain: 'foo')

      expect(status).to be 201
    end
  end
end
