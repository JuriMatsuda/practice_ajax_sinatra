require "sinatra"
require "sinatra/reloader"
require "active_record"

ActiveRecord::Base.establish_connection(
    "adapter" => "sqlite3",
    "database" => "./db/bbs.db"
)

class App < Sinatra::Base

  get '/' do
    @comments = Comment.order('id desc').all
    slim :index
  end

  get '/member/:name' do
    member_age = rand(100)
    content_type :json
    data = {name: params[:name], age: member_age}
    data.to_json
  end

end

after do
  ActiveRecord::Base.connection.close
end
