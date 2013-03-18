require 'compass'
require 'sinatra'
require 'sinatra/cache'
require 'slim'
require "sinatra/reloader" if development?

configure do
  set :scss, {:style => :compact, :debug_info => false}
  Compass.add_project_configuration(File.join(Sinatra::Application.root, 'config', 'compass.rb'))

  register(Sinatra::Cache)
  set :root, File.dirname(__FILE__)
  set :cache_enabled, true
  set :cache_output_dir, Proc.new { File.join(root, 'public', 'cache') }
end

get '/stylesheets/:name.css' do
  content_type 'text/css', :charset => 'utf-8'
  scss(:"stylesheets/#{params[:name]}" )
end

get '/' do
  slim :home
end