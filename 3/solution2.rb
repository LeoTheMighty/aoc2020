def count_trees(down, right)
  trees = 0
  index = 0
  index_r = 0
  open('input.txt').each do |line|
    if (index % down == 0)
      if line[(right * index_r) % (line.length - 1)] == '#'
        line[(right * index_r) % (line.length - 1)] = 'X'
        trees += 1
      else
        line[(right * index_r) % (line.length - 1)] = 'O'
      end
      index_r += 1
    end
    index += 1
    puts line
  end
  trees
end

# puts count_trees(1, 3)
puts count_trees(2, 1)

puts count_trees(1, 3) * count_trees(1, 5) * count_trees(1, 7) * count_trees(1, 1) * count_trees(2, 1)

