class Release < ActiveRecord::Base
  serialize :config

  belongs_to :user
  belongs_to :proxy
  has_many :functions

  has_secure_token :version

  validates :proxy, presence: true
  after_save :set_in_redis

  def key_addons
    "at:addons:#{proxy.subdomain}"
  end

  def key_middleware
    "at:middleware:#{proxy.subdomain}"
  end

  private

  def set_in_redis
    if done
      $redis.del(key_addons)
      config.fetch("addons", {}).each_pair do |addon_name, addon_config|
        $redis.rpush(key_addons, addon_name)
        addon_config.each_pair do |key, value|
          $redis.hset("#{key_addons}:config", key, value)
        end
      end

      $redis.del(key_middleware)
      config.fetch("middleware",[]).each do |name|
        if function = functions.find{|x| x.name == name}
          $redis.rpush(key_middleware, function.content)
        end
      end
    end
  end

end
