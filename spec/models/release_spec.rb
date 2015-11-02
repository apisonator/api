require 'rails_helper'

RSpec.describe Release, type: :model do
  it "serialize config" do
    proxy = create(:proxy)
    config = {foo: :bar, array: [:a, :b, :c]}
    release = Release.new(config: config, proxy: proxy)

    expect(release.config).to eq config
    expect(release.save).to be true
    release.reload

    expect(release.config).to eq config
  end
end
