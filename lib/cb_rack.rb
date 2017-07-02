# require 'erb'
require_relative 'controllers/action_controller'

class CbRack
  attr_reader :request, :action

  def self.call(env)
    new(env).response.finish
  end

  def initialize(env)
    @request = Rack::Request.new(env)
    @action = Action.new(@request)
  end

  def response
    case @request.path
    when '/'
      @action.index
    when '/start_game'
      @action.start_game
    when '/try'
      @action.try
    when '/get_hint'
      @action.get_hint
    else
      Rack::Response.new('Not Found', 404)
    end
  end

  private

  # def game
  #   game_state = @request.session[:game_state] || {}
  #   Codebreaker::Game.new(game_state)
  # end
end
