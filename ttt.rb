
class TicTacToe
  
  attr_accessor :guessed_letters
  
  def initialize(p1,p2)
    @p1 = p1
    @p2 = p2
  end
  
  def display
   puts @p1.check_guess(@p2.guessed)
  end
  
  def won?
    word = @p1.check_guess(@p2.guessed)
    word_arr = word.split('')
    return false if word_arr.include?("-")
    true
  end
  
  def run
    #take guess
    #if valid add it do guessed_letters
    #display it
    #if more then ten guesses game over
    @p1.choose_word
    puts "#{@p1.word.length} letter word"
    # while display.split("").include?("-")
      @p2.guess
      display 
    # end
    puts "game over"
  end
  
end


class HumanPlayer
  attr_accessor :word, :guessed
  
  def choose_word
    puts "Choose a word"
    @word = gets.chomp
  end
  
  def guess
    letters = ("a".."z").to_a
    letter = gets.chomp.downcase
    until letter.length == 1 && letters.include?(letter)
      letter = gets.chomp
    end
    @guessed << letter
    letter
  end
  
  def check_guess(guessed_letters)
    display = "-" * @word.length
    chars = @word.split("")
    guessed_letters.each do |guess|
      if chars.include?(guess)
        n = 0
        while n < @word.length
          display[n] = guess if guess == @word[n]
          n +=1
        end
      end
    end
    display
  end
  
  
  
end


class ComputerPlayer
  attr_accessor :word, :guessed
  
  def initialize
    @letters = ("a".."z").to_a
    @guessed = []
  end
  
  def choose_word
    @word = File.readlines('dictionary.txt').map(&:chomp).sample
  end
  
  def guess
    letter = @letters.sample
    @letters.delete(letter)
    @guessed << letter
    letter
  end
  
  def check_guess(guessed_letters)
    display = "-" * @word.length
    chars = @word.split("")
    guessed_letters.each do |guess|
      if chars.include?(guess)
        n = 0
        while n < @word.length
          display[n] = guess if guess == @word[n]
          n +=1
        end
      end
    end
    display
  end
  
end

a = HumanPlayer.new
p a.class
b = ComputerPlayer.new
c = TicTacToe.new(a,b)
p c
c.run

