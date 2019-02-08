class HangpersonGame
  # Declare attribute accesors
  attr_accessor :word, :guesses, :wrong_guesses

  # Initialize
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  # Method responsible for guessing letter
  def guess(letter)
    # Raise an argument if letter is empty or is not a letter
    if letter == nil or not letter =~ /^[a-zA-Z]$/i 
      raise ArgumentError 
    end
    
    # Letter to lower case
    letter = letter.downcase
    
    if (@word.include? letter) && (!@guesses.include? letter) # correct guess
      @guesses << letter
      true
    elsif (!@word.include? letter) && (!@wrong_guesses.include? letter) # wrong guess
      @wrong_guesses << letter
      true
    else
      false
    end
  end
  
  def word_with_guesses
    result = ''
    
    @word.split('').each do |letter|
      result << letter if @guesses.include? letter
      result << '-' if ! @guesses.include? letter
    end
    
    result
  end
  
  # Method responsible for checking game condition
  def check_win_or_lose
    guess = self.word_with_guesses
    
    if guess == '-' or @wrong_guesses.length == 7 # check if ran out of guesses
      :lose
    elsif guess == @word and @wrong_guesses.length < 7  # check if word was guessed
      :win
    else
      :play # if still haven't reached wrong guesses continue playing
    end
  end
    
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end