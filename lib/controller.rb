require 'gossip'
class ApplicationController < Sinatra::Base

  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    gossip = Gossip.new(params["gossip_author"], params["gossip_content"])
    gossip.save
    redirect to('/')
  end

  get '/gossips/:id' do

    id = params['id']

    gossip = Gossip.find(id)
  
    if gossip
        erb :show, locals: { gossip: gossip, gossip_id: id }
    else
        "Aucun potin trouvé avec l'ID #{id}"
    end
  end

  get '/gossips/:id/?' do
    redirect to("/gossips/#{params['id']}") 
  end

end