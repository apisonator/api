class Proxy < ActiveRecord::Base
  belongs_to :user

  validates :subdomain, presence: true, uniqueness: true
  validates :endpoint, presence: true

  after_create :set_in_redis

  def key_subdomain
    "at:subdomain:#{subdomain}"
  end

  private

  def set_in_redis
    $redis.set(key_subdomain, endpoint)
  end
end
