module Codebreaker
  class Game
    WIN_STRING = '++++'.freeze
    MAX_ATTEMPTS = 5

    attr_accessor :secret_code, :cb_code, :hint_counter,
     :result, :hint_number, :attempt_counter
    attr_reader :game_history

    def initialize(**game_state)
      @secret_code = game_state[:secret_code] || ''
      @hint_counter = game_state[:hint_counter] || 0
      @attempt_counter = game_state[:attempt_counter] || 1
      @game_history = game_state[:game_history] || []

      @result = ''
      @cb_code = ''
    end

    def start
      @attempt_counter = 1
      @hint_counter = 0
      @secret_code = generator
    end

    def generator
      4.times.map { rand(1..6) }.join
    end

    def respond
      @result.clear
      @attempt_counter += 1
      checker(@secret_code.split(''), @cb_code.split(''))
      update_game_history
    end

    def hint
     @hint_counter += 1
     @hint_number = @secret_code[rand(0..3)] if @hint_counter < 2
    end

    def win?
      @result == WIN_STRING
    end

    def loose?
      @attempt_counter == MAX_ATTEMPTS
    end

    def current_state
      return {} if game_end?
      {
        secret_code: @secret_code,
        hint_counter: @hint_counter,
        attempt_counter: @attempt_counter,
        game_history: @game_history
      }
    end

    private

    def game_end?
      win? || loose?
    end

    def update_game_history
      @game_history.push({ you: @cb_code, result: @result })
    end

    def checker(secret_code, cb_code)
      return @result = '++++' if secret_code ==cb_code
      exclude_match = cb_code.zip(secret_code)
      .select { |guess, secret| guess != secret}.transpose
      @result = '+' * (4 - exclude_match[0].size)
      include_matches(exclude_match[0], exclude_match[1])
    end

    def include_matches(secret_code, cb_code)
      secret_code.each do |val|
        next if !cb_code.include?(val)
        cb_code.delete_at(cb_code.index(val))
        @result += '-'
      end
    end
  end
end
