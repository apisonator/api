require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Functions' do

  before do
    @release = create(:release)
  end

  let(:api_key) {
    @release.user.api_key
  }

  let(:release_id) {
    @release.id
  }

  parameter :api_key, 'API Key', required: true, type: :string
  parameter :release_id, 'Release ID', required: true, type: :integer

  post '/api/v1/releases/:release_id/functions' do
    parameter :name, 'Name of the function', required: true, type: :string
    parameter :content, 'Content of the function', required: true, type: :string
    parameter :position, 'Position', required: false, type: :string

    example 'Create a function' do
      do_request(name: 'name', content: 'content', position: 2)
      expect(status).to be 201
    end
  end

  get '/api/v1/releases/:release_id/functions/:id' do
    example 'Get a function' do
      function = create(:function, release: @release)
      do_request(id: function.id)
      expect(status).to be 200
    end
  end

  get '/api/v1/releases/:release_id/functions' do
    example 'Get the functions list' do
      create(:function, release: @release)
      do_request(release_id: release_id)
      expect(status).to be 200
    end
  end


end
