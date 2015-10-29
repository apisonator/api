class Release < ActiveRecord::Base
  belongs_to :user
  belongs_to :proxy
  has_many :functions

  has_secure_token :version

  validates :proxy, presence: true
  before_validation :parse_config, on: :create
  after_save :set_in_redis

  def key_addons
    "at:addons:#{proxy.subdomain}"
  end

  def key_middleware
    "at:middleware:#{proxy.subdomain}"
  end

  private

  def parse_config
    data = YAML::load(config)
    self.proxy = self.user.proxies.find_by(subdomain: data["subdomain"])
  end

  def set_in_redis
    data = YAML::load(config)
    $redis.del(key_addons)
    data.fetch("addons", {}).each_pair do |addon_name, addon_config|
      $redis.rpush(key_addons, addon_name)
      addon_config.each_pair do |key, value|
        $redis.hset("#{key_addons}:config", key, value)
      end
    end

    if done
      $redis.del(key_middleware)
      data.fetch("middleware",[]).each do |name|
        function = functions.find{|x| x.name == name}
        $redis.rpush(key_middleware, function.content)
      end
    end
  end

end
