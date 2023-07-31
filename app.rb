require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './helpers'
require 'securerandom'

class App < Sinatra::Base
  configure do
    enable :sessions
    set :json_encoder, :to_json
    set :erb, layout: :layout
  end

  before do
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Headers'] = 'accept, authorization, origin'
  end

  options '*' do
    response.headers['Allow'] = 'HEAD,GET,PUT,DELETE,OPTIONS,POST'
    response.headers['Access-Control-Allow-Headers'] =
      'X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept'
  end

  get '/' do
    @link = ShortLink.new
    erb :index
  end

  post '/links' do
    short_url_string = SecureRandom.alphanumeric(12)

    link = ShortLink.create(
      long_url: params[:long_url],
      short_url: short_url_string
    )

    redirect to("/show/#{link.id}")
  end

  get '/show/:id' do
    @link = ShortLink.find(params[:id])

    erb :show
  end

  get '/links/:short_url' do
    @link = ShortLink.find(params[:short_url])
    link_visits = @link.visits.to_i
    @link.update(visits: link_visits + 1)

    redirect to("http://localhost:9292/#{link.long_url}")
  end

end