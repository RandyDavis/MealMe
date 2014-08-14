require 'rack-flash'
require 'sinatra/redirect_with_flash'
require 'sinatra'
require 'sinatra/activerecord'
require './environments'
require 'yelp'
require 'json'

set :sessions, true
use Rack::Flash
set :bind, '0.0.0.0'

class MealPlan < ActiveRecord::Base
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
  has_many  :meals
  has_many  :plans
end


get "/" do
 erb :index
end

get '/search' do
  client = Yelp::Client.new({ consumer_key: "q_5VHCkxQcT1B4hxcCM_2w",
                              consumer_secret: "4HOFnWO9NT0anZexVqmiVyKzp5Q",
                              token: "oBXssmNMaG2_AiyF0zG2XYEe185eLu89",
                              token_secret: "VKIIJWYw2Qc-XBlwhQzDxs1i5DY"
                            })
  params = { term: 'franks',
           limit: 3,
           # category_filter: 'discgolf'
         }

locale = { lang: 'fr' }

response = client.search('Austin', params, locale)
  search_results = JSON.parse(response.to_json)
  first_name = search_results["businesses"].first["name"]
  first_url = search_results["businesses"].first["url"]

  "<h2><a href='#{first_url}'>#{first_name}</a></h2>"
end