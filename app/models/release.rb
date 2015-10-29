class Release < ActiveRecord::Base
  belongs_to :user
  has_many :functions

  has_secure_token :version

end
