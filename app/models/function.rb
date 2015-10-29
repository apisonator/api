class Function < ActiveRecord::Base
  belongs_to :release

  validates :name, presence: true, uniqueness: {scope: :id}
  validates :content, presence: true
end
