require 'open-uri'
require 'nokogiri'

class GamesController < ApplicationController
  def new
    @letters = [*('A'..'Z')].sample(10)
  end

  def score
    # raise
    @word = params[:word]
    @words = @word.upcase.split("")
    @letters = params[:selected_letters]
    @letterss = @letters.split

    if !(@letterss & @words).any? && english_word?(@word) == true
      @result = "Congratulations! #{@word.upcase} is a valid English word"
    elsif @word == ''
      @result = 'Input a word to play'
    elsif english_word?(@word) == false
      @result = "Sorry but #{@word.upcase} does not seem to be a valid English word"
    else
      @result = "Sorry but TEST can\'t be built out of #{@letters.gsub(" ", ", ")}"
    end
  end

  private

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    html = URI.open(url).read
    user = JSON.parse(html)
    user["found"]
  end
end
