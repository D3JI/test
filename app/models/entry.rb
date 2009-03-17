class Entry < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  belongs_to :user, :counter_cache => true
end
