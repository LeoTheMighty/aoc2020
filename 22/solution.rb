require 'set'

def get_decks
  deck_1 = []
  deck_2 = []
  players = open('input.txt').read.split("\n\n")

  players[0].split("\n")[1..].each do |line|
    deck_1 << line.to_i
  end
  players[1].split("\n")[1..].each do |line|
    deck_2 << line.to_i
  end
  [deck_1, deck_2]
end

deck_1, deck_2 = get_decks
while !deck_1.empty? && !deck_2.empty?
  c1 = deck_1.shift
  c2 = deck_2.shift
  if c1 > c2
    deck_1 << c1
    deck_1 << c2
  else
    deck_2 << c2
    deck_2 << c1
  end
end

[deck_1, deck_2].each do |deck|
  sum = 0
  deck.each_with_index do |e, i|
    m = deck.length - i
    sum += (m * e)
  end
  puts sum
end

# Recursive Combat
deck_1, deck_2 = get_decks

# return the score of the game (negative for player 2 win)
def play_game(deck_1, deck_2)
  configs = Set[]
  # Each round
  while !deck_1.empty? && !deck_2.empty?
    # Check for repetition
    r = deck_1.to_s + deck_2.to_s
    if configs.include? r
      return 1
    else
      configs << r
    end

    c1 = deck_1.shift
    c2 = deck_2.shift

    if c1 <= deck_1.length && c2 <= deck_2.length
      # play subgame
      p1_win = play_game(deck_1[0..(c1 - 1)], deck_2[0..(c2 - 1)]) > 0
    else
      p1_win = c1 > c2
    end
    if p1_win
      deck_1 << c1
      deck_1 << c2
    else
      deck_2 << c2
      deck_2 << c1
    end
  end

  s1 = 0
  s2 = 0
  deck_1.each_with_index { |e, i| s1 += ((deck_1.length - i) * e) }
  deck_2.each_with_index { |e, i| s2 += ((deck_2.length - i) * e * -1) }

  s1.abs > s2.abs ? s1 : s2
end

puts play_game(deck_1, deck_2)
