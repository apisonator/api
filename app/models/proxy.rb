class Proxy < ActiveRecord::Base
  belongs_to :user

  validates :subdomain, presence: true, uniqueness: true
  validates :endpoint, presence: true
end
