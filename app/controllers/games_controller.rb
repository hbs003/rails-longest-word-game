require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.shuffle[0..10]
  end

def included?(word, letters)
  word.chars.all? { |letter| word.count(letter) <= letters.count(letter)}
end

def englishword?(word)
  response = open("https://wagon-dictionary.herokuapp.com/#{word}")
  @json = JSON.parse(response.read)
  return @json['found']
end

def yourscore(word)
  if englishword?(word)
    return @json['length']
  end
end

  def score
    # raise
    @letters_array = params[:letters].split('')
    @word = params[:word].downcase
    @value = included?(@word,@letters_array)
    @exist = englishword?(@word)
    @score = yourscore(@word)
  end

end



  # def score
  #   # raise
  #   letters_array = params[:letters].split('')
  #   word_array = params[:word].downcase.split('')
  #   @value = (word_array - letters_array).empty?
  # end
