require 'sinatra'
require 'open-uri'
require 'nokogiri'

#set :port, 3000
set :protection, :except => [:json_csrf]

get '/' do
  puts 'Basic GET'
  status 200
  headers \
    'Content-Type' => 'application/json'
  body '{"response_type": "in_channel","text": "It works!"}'
end
  
get '/emote' do
   puts 'a GET for ' + params['text']
   status 200
   headers \
   'Content-Type' => 'application/json'
   body '{ "test": "yep, it worked" }'
end
