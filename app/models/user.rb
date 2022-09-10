class User < ActiveRecord::Base
    has_many :ratings
    has_many :games, through: :ratings
  end
  