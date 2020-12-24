# INPUT = "614752839"
INPUT = "389125467" # Test input
MOVES = 100
# MOVES = 10000000
BIG_CUP_SIZE = 1000000
CUP_SIZE = 10
REAL_CUP_SIZE = CUP_SIZE
# REAL_CUP_SIZE = BIG_CUP_SIZE

def big_cups!(cups)
  CUP_SIZE.upto(BIG_CUP_SIZE) do |i|
    cups << i
  end
end

def cups_string(cups)
  cups.map { |i| i.to_s }.join("")
end

def pick_up_cup(cups, i)
  cups.slice!(i % cups.length)
end

def get_cup(cups, cup_i)
  cups[cup_i % cups.length]
end

def get_cup_i(cups, cup)
  cups.index(cup)
end

def play_crab_cup(input)
  # create
  cups = input.chars.map { |c| c.to_i }
  big_cups! cups if REAL_CUP_SIZE == BIG_CUP_SIZE
  current_cup = cups[0]
  current_cup_i = 0
  1.upto(MOVES) do |n|
    puts "Round #{n}: #{cups_string(cups)}, Current = #{current_cup}"
    c1 = get_cup(cups, current_cup_i + 1)
    c2 = get_cup(cups, current_cup_i + 2)
    c3 = get_cup(cups, current_cup_i + 3)
    a = 0
    cups.delete c1
    cups.delete c2
    cups.delete c3
    # if REAL_CUP_SIZE - current_cup_i < 3
    #   a = 3 - (REAL_CUP_SIZE - current_cup_i + 1)
    #   cups.slice!(0, a)
    #   current_cup_i -= a
    # end
    # cups.slice!(current_cup_i + 1, 3 - a)

    puts "Pick Up: #{cups_string([c1, c2, c3])}"
    next_cup = (current_cup - 1) % REAL_CUP_SIZE
    # pick_up = [c1, c2, c3, 0]
    next_cup = (next_cup - 1) % REAL_CUP_SIZE until cups.include? next_cup

    puts "Destination: #{next_cup}"
    next_cup_i = get_cup_i(cups, next_cup)

    cups.insert(next_cup_i + 1, c1, c2, c3)

    current_cup_i = (get_cup_i(cups, current_cup) + 1) % cups.length
    current_cup = cups[current_cup_i]
    puts
    # puts "Round #{n}" if n % 100 == 0
  end
  cups
end

cups = play_crab_cup(INPUT)
puts cups_string cups
i = get_cup_i(cups, 1)
puts get_cup(cups, i + 1) * get_cup(cups, i + 2)