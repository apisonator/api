class Proxy < ActiveRecord::Base
  belongs_to :user
  has_many :releases

  validates :subdomain, uniqueness: true, format: { with: /\A\w[\w\-\/_]+\z/ }
  validates :endpoint, presence: true

  after_create :set_in_redis

  has_secure_token :subdomain

  def key_subdomain
    "at:subdomain:#{subdomain}"
  end

  private

  def set_in_redis
    $redis.set(key_subdomain, endpoint)
  end
end
