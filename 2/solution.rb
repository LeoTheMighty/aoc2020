valid = 0

open('input.txt').each do |line|
  dash = line.index('-')
  space = line.index(' ')
  colon = line.index(':')
  min = line[0..(dash - 1)].to_i
  max = line[(dash + 1)..(space - 1)].to_i
  character = line[colon - 1]

  sequence = line[(colon + 2)..-1]
  occurences = 0
  sequence.each_char do |c|
    if c == character
      occurences += 1
      if occurences > max
        occurences = -1
        break
      end
    end
  end
  if occurences >= min
    valid += 1
  end
end

puts valid

