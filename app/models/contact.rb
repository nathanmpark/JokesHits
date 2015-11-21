class Contact < ActiveRecord::Base
  has_many :users, through: :histories
  has_many :histories
end
