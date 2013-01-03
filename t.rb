require 'sinatra'
require 'json'

savedData = Hash.new

get '/' do
  'running'
end

get '/all' do
  "data:<br>#{savedData.to_json}<br>"
end

get '/session/:id' do
  "#{params[:id]}=#{savedData[params[:id]].to_json}"
end 

post '/' do
  request.body.rewind  # in case someone already read it
  data = JSON.parse request.body.read
  id = data['sessionId']
  prevData = savedData[id]
  savedData[id] = prevData ? prevData.merge(data) : data 
  "Processed data for session #{id}\n"
end
