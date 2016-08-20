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
   page = Nokogiri::HTML(open('http://forums.somethingawful.com/misc.php?action=showsmilies'))
   puts 'a GET for ' + search
   items = page.css('div.text')
     items.each do |item|
      if item.text =~ /#{search}/
        puts 'found it'
        @img = item.next_element['src'].to_s
      end
     end
   status 200
   headers \
   'Content-Type' => 'application/json'
   body '{ "response_type": "in_channel", "text": "' + @img + '" }'
end
