class Release < ActiveRecord::Base
  belongs_to :user
  belongs_to :proxy

  has_secure_token :version

  validates :proxy, presence: true
  before_validation :parse_config, on: :create

  private

  def parse_config
    data = YAML::load(config)
    self.proxy = self.user.proxies.find_by(subdomain: data["subdomain"])
  end

end
