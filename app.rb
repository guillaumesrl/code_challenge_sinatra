require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "yaml"

before do
  @users = YAML.load_file('data/users.yml')
end

helpers do
  def counter_interests
    @users.each_with_object([]) { |user, arr| arr <<  user[1][:interests].size if user[1][:interests] }.sum
  end
end

def other_users
  @other_users = @users.keys-[params[:name].to_sym]
end

get "/" do
  redirect "/users"
end

get "/users" do
  erb :users_list
end

get "/users/:name" do
  @user = params[:name]
  @email = @users[params[:name].to_sym][:email]
  @interests = @users[params[:name].to_sym][:interests]
  @other_users = other_users
  erb :user_page
end
