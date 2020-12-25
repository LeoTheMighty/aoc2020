$tiles = {}

def get_r_c(k)
  k.split(",").map { |s| s.to_i }
end

def flip(tiles, r, c)
  k = "#{r},#{c}"
  tiles[k] = 1 unless tiles.has_key?(k)
  tiles[k] == 1 ? tiles[k] = 0 : tiles[k] = 1
end

def black?(tiles, k)
  tiles[k] == 0
end

def how_many_black(tiles)
  count = 0
  tiles.each do |_k, v|
    count += 1 if v == 0
  end
  count
end

def get_adjacent_keys(r, c)
  [
    "#{r},#{c + 2}",     # e
    "#{r},#{c - 2}",     # w
    "#{r + 2},#{c + 1}", # ne
    "#{r + 2},#{c - 1}", # nw
    "#{r - 2},#{c + 1}", # se
    "#{r - 2},#{c - 1}", # sw
  ]
end

def init_adjacent(tiles, r, c)
  get_adjacent_keys(r, c).each { |k| tiles[k] = 1 unless tiles.has_key?(k) }
end

def init_all_adjacent(tiles)
  all = []
  tiles.each do |k, v|
    r, c = get_r_c k
    all << [r, c]
  end
  all.each do |s|
    init_adjacent tiles, s[0], s[1]
  end
end

def how_many_adjacent(tiles, r, c)
  keys = get_adjacent_keys r, c
  count = 0
  keys.each { |k| count += 1 if black?(tiles, k) }
  count
end

def do_day(n)
  # add white tiles
  init_all_adjacent $tiles
  to_flip = []
  $tiles.each do |k, v|
    r, c = get_r_c k
    adjacent = how_many_adjacent($tiles, r, c)
    if v == 0 && (adjacent == 0 || adjacent > 2)
      to_flip << [r, c]
    elsif v == 1 && (adjacent == 2)
      to_flip << [r, c]
    end
  end
  to_flip.each do |s|
    flip($tiles, s[0], s[1])
  end
  puts "Day #{n}: #{how_many_black($tiles)}"
end

open('input.txt').each do |line|
  ns = ''
  steps = []
  line.each_char do |c|
    if c == 'e' || c == 'w'
      steps << "#{ns}#{c}"
      ns = ''
    else
      ns = c
    end
  end
  # steps.each { |s| print "#{s}, "}
  # print "\n"
  # $stdout.flush
  r = 0
  c = 0
  steps.each do |step|
    r_i = 0
    c_i = 0
    if step[-1] == 'w'
      c_i = -2
    elsif step[-1] == 'e'
      c_i = 2
    end
    if step[0] == 'n'
      r_i = 2
      c_i /= 2
    elsif step[0] == 's'
      r_i = -2
      c_i /= 2
    end
    r += r_i
    c += c_i
  end
  flip($tiles, r, c)
end

puts how_many_black($tiles)

1.upto(100) do |n|
  do_day n
end