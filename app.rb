require 'rack-flash'
require 'sinatra/redirect_with_flash'
require 'sinatra'
require 'sinatra/activerecord'
require './environments'
require 'yelp'
require 'json'
require 'oauth'
require 'pry-byebug'
require 'bcrypt'

set :sessions, true
use Rack::Flash
set :bind, '0.0.0.0'

# api_host = 'api.yelp.com'

# consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
# access_token = OAuth::AccessToken.new(consumer, token, token_secret)

# path = “/v2/search?term=restaurant&location=austin”

# yelp_data = JSON(access_token.get(path).body). 

before do
  def login
    @user = User.find_by_id(params[:id])
    if @user.password == params[:password_digest]
      redirect_to "/planning", :notice => 'Successfully signed in!'
    else
      redirect_to "/login", :error => 'Something went wrong.  Try again.  (This message will disappear in 4 seconds.)'
    end
  end
end


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

class User < ActiveRecord::Base
  has_many :plans

  # users.password_digest in the database is a :string
  include BCrypt

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end

  # def create
  #   @user = User.new(params[:user])
  #   @user.password = params[:password]
  #   @user.save!
  # end
end

class Meal < ActiveRecord::Base
  has_many :plans, through: :plan_meals
  has_many :plan_meals
end

class Plan < ActiveRecord::Base
  has_many :meals, through: :plan_meals
  has_many :plan_meals
  has_one :users
end

get "/" do
 erb :index
end

get "/newPlan" do
  erb :newPlan
end



post "/newPlan" do
  # binding.pry

  data = {
    term: params["Restaurant"],
    limit: 3
  }

  p data


  path = "/v2/search?term=restaurants+#{params['Restaurant']}&location=austin"

  consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://api.yelp.com"})
  access_token = OAuth::AccessToken.new(consumer, token, token_secret)

  @search_response = JSON(access_token.get(path).body)

  # @restaurant = search_response['businesses'].first['name']
  # @url = search_response['businesses'].first['url']

  # "<a href='#{search_response['businesses'].first['url']}'>#{search_response['businesses'].first['name']}</a>"

  # response = client.search('Austin', data)#, { lang: 'en' })
  # search_results = JSON.parse(response.to_json)
  # first_name = search_results["businesses"].first["name"]
  # first_url = search_results["businesses"].first["url"]

  # @restaurant = first_name
  # @url = first_url

  erb :newPlan
end


post '/saverestaurants' do
  restaurants = params.values.map { |x| x.split("xx") }

  restaurants.each do |r|
    # r.first is the restaurant name. r.last is the category
    some_method_to_save_in_db(r.first, r.last)
  end

  redirect to '/newPlan'
end





