require 'sinatra'
require "sinatra/reloader" if development?
require 'slim'
require 'compass'

configure do
  set :scss, {:style => :compact, :debug_info => false}
  Compass.add_project_configuration(File.join(Sinatra::Application.root, 'config', 'compass.rb'))
end

get '/stylesheets/:name.css' do
  content_type 'text/css', :charset => 'utf-8'
  scss(:"stylesheets/#{params[:name]}" )
end

get '/' do
  slim :home
end