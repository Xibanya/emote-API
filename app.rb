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
  puts 'Looking for emote ' + params['text']
  page = Nokogiri::HTML(open('http://forums.somethingawful.com/misc.php?action=showsmilies'))
  search = ':' + params['text'] + ':'
  items = page.css('div.text')
  items.each do |item|
    if item.text =~ /#{search}/
      status 200
      headers \
        'Content-Type' => 'application/json'
      body '{"response_type": "in_channel","text": "' + item.next_element['src'].to_s + '"}'
    end
  end
end
