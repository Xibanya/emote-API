require 'sinatra'
require 'nokogiri'
require 'open-uri'

PAGE_URL = 'http://forums.somethingawful.com/misc.php?action=showsmilies'

get '/' do
  "heya"
  status 200
  headers \
    'Content-Type' => 'application/json'
  body '{"response_type": "in_channel","text": "It works!"}'
end

get '/emote' do
  page = Nokogiri::HTML(open(PAGE_URL))
  search = ':' + params['text'] + ':'
  items = page.css('div.text')
  items.each do |item|
    if item.text =~ /#{search}/
      headers \
        'Content-Type' => 'application/json'
      body '{"response_type": "in_channel","text": "' + item.next_element['src'].to_s + '"}'
    end
  end
end
