require 'rack-flash'
require 'sinatra/redirect_with_flash'
require 'sinatra'
require 'sinatra/activerecord'
require './environments'
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

get "/" do

end