require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Releases' do

  before do
    @user = create(:user)
    @proxy = create(:proxy, subdomain: 'foo', user: @user)
  end

  let(:api_key) {
    @user.api_key
  }

  let(:config) {
    {'middleware' => [:a, :b, :c]}
  }

  let(:subdomain) {
    @proxy.subdomain
  }

  parameter :api_key, 'API Key', required: true, type: :string

  get '/api/v1/proxies/:subdomain/releases' do
    example 'Listing releases' do
      release = create(:release, proxy: @proxy, user: @user)
      release = create(:release, proxy: @proxy, user: @user)
      do_request
      expect(status).to be 200
    end
  end

  post '/api/v1/proxies/:subdomain/releases' do
    parameter :subdomain, 'Subdomain', required: true, type: :string
    parameter :config, 'Config', required: true, type: :object

    example 'Creating a release' do
      do_request(config: config)
      expect(status).to be 201
    end
  end

  post '/api/v1/proxies/:subdomain/releases/:id/deploy' do
    example 'Deploy a release' do
      release = create(:release, proxy: @proxy, user: @user)

      do_request(id: release.id)

      expect(status).to be 201
    end
  end

end
