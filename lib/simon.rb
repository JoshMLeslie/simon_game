class Simon
  # and other late 70s/80s iconography references.
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize(sequence_length = 1)
    @sequence_length = sequence_length
    @game_over = false
    @seq = []
  end

  def play
    until game_over # catch again?
      take_turn until game_over
      game_over_message
      reset_game if again?
    end
    system "clear"
    puts "So long, and thanks for all the colors."
  end

private
  def take_turn
    system "clear"
    puts "Turn number: #{sequence_length}"
    sleep(3)
    show_sequence
    require_sequence
    round_success_message unless game_over
  end

  def show_sequence
    add_random_color

    seq.each do |color|
      system "clear"
      puts ""
      puts color.center(10)
      timer_render
    end

    system "clear"
  end

  def timer_render
    sleep (1)
    puts "#"
    sleep (1)
    puts "# #"
    sleep (1)
  end

  def require_sequence
    puts "Colors are case sensitive."
    puts "Input all colors at once, deliniated"
    puts ""
    user_seq = gets.chomp.scan(/\w+/)

    # if user_seq does not equal seq cause game_over is inverse-y.
    @game_over = (user_seq != seq)
  end

  def add_random_color
    @seq << COLORS.sample
    @sequence_length += 1
  end

  def round_success_message
    system "clear"
    puts "You survived another round."
    puts "Can you survive one more?"
    sleep(3)
    system "clear"
  end

  def game_over_message
    system "clear"
    puts "Well that's great, just great, man! \nNow what are we supposed to do? What are we gonna do? \nThat's it man. Game over, man! \nGame over!\n\n"
    puts "You survived #{sequence_length-2} round(s), congrats!\n"

    sleep(5)
    system "clear"


    puts "What, you finished? Maybe we could build a fire, sing a couple songs! \nWe could try that!"
    puts "    (y/n)"
  end

  def again?
    (gets =~ /y|Y/) == 0
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Simon.new
  game.play
end
