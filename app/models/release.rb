class Release < ActiveRecord::Base
  belongs_to :user

  has_secure_token :version
end
