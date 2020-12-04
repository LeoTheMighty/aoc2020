trees = 0
index = 0
r = 0
open('input.txt').each do |line|
  if line[(3 * index) % (line.length - 1)] == '#'
    line[(3 * index) % line.length] = 'X'
    trees += 1
  else
    line[(3 * index) % line.length] = 'O'
  end
  puts line
  index += 1
end
puts trees
