require 'net/http'
require 'json'

class GamesController < ApplicationController
  # NEW_CHARS = ('a'..'z').to_a.sample(10)

  def new
    # @new_chars = NEW_CHARS
    @new_chars = ('a'..'z').to_a.sample(10)
  end

  def score
    @answer = params[:answer]
    @new_chars = params[:chars]
    @built_with_arr = true
    @answer.split('').each do |char|
      @built_with_arr = false unless @new_chars.include?(char)
    end
    @check_word = JSON.parse(Net::HTTP.get(URI.parse("https://wagon-dictionary.herokuapp.com/#{@answer}")))
    @score = @check_word['length']
    @valid = @check_word['found']

    if !@built_with_arr
      @score = 0
      @message = "Answer not built from #{@new_chars}"
    elsif @valid
      @message = 'Congrats, you scored!'
    else
      @score = 0
      @message = 'Not a English word'
    end
  end
end
