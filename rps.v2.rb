class Player
  attr_accessor :name, :choice

  def initialize(name)
    @name = name
  end
end

class Human < Player
  def shoot
    begin
      puts "Please choose one: Rock(r), Paper(p), Scissors(s)"
      self.choice = gets.chomp.downcase
    end until  Game::CHOICES.keys.include?(choice)
  end

  def set_name
    puts "Welcome to Rock, Paper Scissors!"
    puts "What is your name?"
    self.name = gets.chomp
  end

end

class Computer < Player
  def shoot
    self.choice = Game::CHOICES.keys.sample
  end
end

module Hand

  def compare_hands
    if player.choice == computer.choice
      puts "\nIt's a tie!"
    elsif player.choice == 'p' && computer.choice == 'r' ||
          player.choice == 'r' && computer.choice == 's' ||
          player.choice == 's' && computer.choice == 'p'
      winning_message(player.choice)
      puts "#{player.name} wins!"
    else
      winning_message(computer.choice)
      puts "#{computer.name} wins!"
    end
  end

  def winning_message(hand)
    if hand == 'r'
      puts "\nRock crushes Scissors!"
    elsif hand == 's'
      puts "\nScissors slice Paper!"
    else
      puts "\nPaper smothers Rock!"
    end
  end

  def display_hand(hand)
    puts "#{hand.name} chose: #{Game::CHOICES[hand.choice]}"
  end

end

class Game
  CHOICES = {'r' => 'Rock', 'p' => 'Paper', 's' => 'Scissors'}
  attr_accessor :player, :computer
  include Hand

  def initialize 
    @player = Human.new(' ')
    @computer = Computer.new('R2D2')
  end

  def replay?
    puts "\nPress any key to play again or 'n' to quit."
    play_again = gets.chomp.downcase
  end

  def play
    player.set_name
    begin
      player.shoot
      computer.shoot
      puts ''
      display_hand(player)
      display_hand(computer)
      sleep(1)
      compare_hands
    end until replay? == 'n'
  end

end

game = Game.new.play
