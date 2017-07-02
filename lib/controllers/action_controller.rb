require 'rack'
require 'erb'
require 'yaml'
require 'securerandom'
# require_relative '../models/game'
require 'pry'

class Action
  def initialize(request)
    @request = request
    # @game = game
  end

  def index
    Rack::Response.new(render('index.html.erb'))
  end

#   def start_game
#     save_user_name
#     @game.start
#     save_game_state
#     Rack::Response.new(render('game.html.erb'))
#   end

#   def try
#     @game.cb_code = @request.params['guess']
#     @game.respond
#     save_game_state
#      view = 'game.html.erb'
#      view = 'loose.html.erb'if @game.loose?
#      view = 'win.html.erb' if @game.win?
#     Rack::Response.new(render(view))
#   end

#   def get_hint
#     @game.hint
#     save_game_state
#      Rack::Response.new(render('game.html.erb'))
#   end

#   def name
#     @request.session[:user_name]
#   end

#   private

  def render(template)
    path = File.expand_path("../../views/#{template}", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end

#   def save_game_state
#     @request.session[:game_state] = @game.current_state
#   end

#   def save_user_name
#     return unless  @request.params['name']
#     @request.session[:user_name] = @request.params['name']
#   end
end
