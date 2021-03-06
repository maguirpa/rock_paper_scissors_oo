class Player
  attr_accessor :name, :choice

  def initialize(name)
    @name = name
  end
end

class Human < Player
  def pick_hand
    begin
    puts "\nPlease chose one: Rock(r), Paper(p) or Scissors(s)."
    self.choice = gets.chomp.downcase
    end until Game::CHOICES.keys.include?(choice)
  end

  def set_name
    puts "Lets play Rock, Paper, Scissors."
    puts "What's your name?"
    self.name = gets.chomp.capitalize!
  end
end

class Computer < Player
  def pick_hand
    self.choice = Game::CHOICES.keys.sample
  end
end

module Hand
  def display_choice(display)
    puts "#{display.name} chose: #{Game::CHOICES[display.choice]}"
  end

  def compare_hands
    if player.choice == computer.choice
      puts "\nIt's a tie!"
    elsif (player.choice == 'r' && computer.choice == 's') || 
          (player.choice == 's' && computer.choice == 'p') || 
          (player.choice == 'p' && computer.choice == 'r') 
      winning_message(player.choice)
      puts "#{player.name} wins!"
    else 
      winning_message(computer.choice)
      puts "Computer wins!"
    end
  end

  def winning_message(hand)
    if hand == 'r'
      puts "\nRock crushes Scissors."
    elsif hand == 's'
      puts "\nScissors cuts Paper."
    else
      puts "\nPaper smothers Rock."
    end
  end  

end

class Game
  CHOICES = {'p' => 'Paper', 'r' => 'Rock', 's' => 'Scissors'}
  attr_accessor :player, :computer, :name
  include Hand

  def initialize
    @player = Human.new(" ")
    @computer = Computer.new("The Robot")
  end

  def replay?
    puts "Press any key to continue or 'n' to quit."
    play_again = gets.chomp.downcase
  end

  def play
    player.set_name
    begin
      player.pick_hand
      computer.pick_hand
      display_choice(player)
      display_choice(computer)
      compare_hands
    end until replay? == 'n'
  end

end

game = Game.new.play
