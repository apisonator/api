class Release < ActiveRecord::Base
  serialize :config

  belongs_to :user
  belongs_to :proxy
  has_many :functions

  has_secure_token :version

  validates :proxy, presence: true

  def key_addons
    "at:addons:#{proxy.subdomain}"
  end

  def key_middleware
    "at:middleware:#{proxy.subdomain}"
  end

  def key_release
    "at:release:#{proxy.subdomain}"
  end

  def deploy!
    $redis.multi do
      $redis.del(key_addons)
      config.fetch("addons", {}).each_pair do |addon_name, addon_config|
        $redis.rpush(key_addons, addon_name)
        addon_config.each_pair do |key, value|
          $redis.hset("#{key_addons}:config", key, value)
        end
      end

      $redis.del(key_middleware)
      config.fetch("middleware",[]).each do |name|
        if function = self.functions.find{|x| x.name == name}
          $redis.rpush(key_middleware, function.content)
        end
      end

      $redis.set(key_release, id)
    end
  end
end
