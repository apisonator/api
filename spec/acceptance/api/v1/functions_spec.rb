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
  parameter :name, 'Name of the function', required: true, type: :string
  parameter :content, 'Content of the function', required: true, type: :string

  post '/api/v1/functions' do
    example 'Create a function' do

      do_request(name: 'name', content: 'content')
      expect(status).to be 201
    end
  end
end
