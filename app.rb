require 'rack-flash'
require 'sinatra/redirect_with_flash'
require 'sinatra'
require 'sinatra/activerecord'
require './environments'
require 'yelp'
set :sessions, true
use Rack::Flash

class Plan < ActiveRecord::Base
  validates :homemade1, presence: true
  validates :homemade2, presence: true
  validates :homemade3, presence: true
  validates :homemade4, presence: true
  validates :homemade5, presence: true
  validates :restaurant1, presence: true
  validates :restaurant2, presence: true
  validates :restaurant3, presence: true
  validates :restaurant4, presence: true
  validates :restaurant5, presence: true
end

@client = Yelp::Client.new({ consumer_key: YOUR_CONSUMER_KEY,
                            consumer_secret: YOUR_CONSUMER_SECRET,
                            token: YOUR_TOKEN,
                            token_secret: YOUR_TOKEN_SECRET
                          })

<!DOCTYPE html>

get "/" do

end