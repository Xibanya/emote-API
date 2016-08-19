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
   search = (':' + params['text'] + ':').to_s
   puts 'a GET for ' + search
   status 200
   headers \
   'Content-Type' => 'application/json'
   body '{ "test": "#{search}" }'
end
