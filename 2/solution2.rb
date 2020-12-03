valid = 0

open('input.txt').each do |line|
  dash = line.index('-')
  space = line.index(' ')
  colon = line.index(':')
  min = line[0..(dash - 1)].to_i
  max = line[(dash + 1)..(space - 1)].to_i
  character = line[colon - 1]
  sequence = line[(colon + 2)..-1]
  c1 = sequence[min - 1]
  c2 = sequence[max - 1]

  valid += 1 if (c1 == character) ^ (c2 == character)
end

puts valid

