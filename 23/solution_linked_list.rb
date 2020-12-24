INPUT = "614752839"
# INPUT = "389125467" # Test input
# MOVES = 100
MOVES = 10000000
BIG_CUP_SIZE = 1000000
CUP_SIZE = 10
# REAL_CUP_SIZE = CUP_SIZE
REAL_CUP_SIZE = BIG_CUP_SIZE

$nodes = Array.new(REAL_CUP_SIZE + 1, -1) # id => [prev, next]

def create_cups(input)
  last_num = nil
  first_num = nil
  input.each_char do |c|
    if last_num
      $nodes[last_num] = c.to_i
    else
      first_num = c.to_i
    end
    last_num = c.to_i
  end
  if REAL_CUP_SIZE == BIG_CUP_SIZE
    CUP_SIZE.upto(BIG_CUP_SIZE) do |i|
      $nodes[last_num] = i
      last_num = i
    end
  end
  $nodes[last_num] = first_num
  puts $nodes.length
  puts $nodes[7]
  puts $nodes[1..].index(-1)
  first_num
end

def get_next(cup, n = 1)
  n = n % REAL_CUP_SIZE
  1.upto(n) do
    cup = $nodes[cup]
  end
  cup
end

def set_next(cup, next_cup)
  $nodes[cup] = next_cup
end

def print_cups(first_cup)
  str = "#{first_cup.to_s}"
  cup = get_next(first_cup)
  while first_cup != cup
    str += cup.to_s
    cup = get_next(cup)
  end
  str
end

def play_crab_cups(first_cup)
  current_cup = first_cup
  1.upto(MOVES) do |n|
    # puts "Round #{n}: #{print_cups(get_prev(current_cup, n - 1))}, Current = #{current_cup}"
    c1 = get_next(current_cup)
    c2 = get_next(c1)
    c3 = get_next(c2)
    # puts "Pick Up: [#{c1}, #{c2}, #{c3}]"

    # will skip
    set_next(current_cup, get_next(c3))

    dest = current_cup - 1
    dest = (dest - 1) % (REAL_CUP_SIZE + 1) while dest == c1 || dest == c2 || dest == c3 || dest == 0
    # puts "Destination: #{dest}"

    set_next(c3, get_next(dest))
    set_next(dest, c1)

    current_cup = get_next(current_cup)
    # puts
  end
end

first_cup = create_cups(INPUT)

play_crab_cups(first_cup)

puts print_cups(1)[1..] if CUP_SIZE == REAL_CUP_SIZE

puts get_next(1)
puts get_next(1, 2)
puts get_next(1) * get_next(1, 2)
puts $nodes[1] * $nodes[$nodes[1]]

# puts $nodes
