require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection

class User < ActiveRecord::Base
  has_secure_password
  has_many :items
  has_many :chats
  has_many :bought_items, class_name: 'Item', foreign_key: 'buyer_id'
end

class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :buyer, class_name: 'User', optional: true
  has_many :chats
end

class Chat < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
end