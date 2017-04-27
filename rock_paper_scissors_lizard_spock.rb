######################### Rock Paper Scissors #########################

class RockPaperScissors
  include Comparable
  attr_accessor :move

  def initialize(move)
    @move = move
  end

  def rules
    {
      rock: [:scissors, :lizard],
      paper: [:rock, :spock],
      scissors: [:paper, :lizard],
      lizard: [:spock, :paper],
      spock: [:scissors, :rock]
    }
  end

  def <=>(other_player)
    return 0 if move == other_player.move

    if rules[move].include? other_player.move
      1
    else
      -1
    end
  end
end
