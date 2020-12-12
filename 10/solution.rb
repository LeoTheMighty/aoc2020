
joltage_adapters = []

open('input.txt').each do |line|
  jolts = line.to_i
  insert_at = joltage_adapters.bsearch_index { |j| j >= jolts } || -1
  joltage_adapters.insert(insert_at, jolts)
end

puts joltage_adapters

target = joltage_adapters[-1]

diff_1 = 0
diff_3 = 0
prev = 0
joltage_adapters.each do |j|
  if j - prev == 1
    diff_1 += 1
  end
  if j - prev == 3
    diff_3 += 1
  end
  prev = j
end

puts diff_1
puts diff_3
puts diff_1 * (diff_3 + 1)

$cache = {}
def combinations(i, l)
  if $cache.has_key? i
    return $cache[i]
  end
  num = 0
  first = l[i]
  return 1 unless first
  if l[i + 1] && l[i + 1] - first < 4
    num += combinations(i + 1, l)
  end
  if l[i + 2] && l[i + 2] - first < 4
    num += combinations(i + 2, l)
  end
  if l[i + 3] && l[i + 3] - first < 4
    num += combinations(i + 3, l)
  end

  if num != 0
    $cache[i] = num
    return num
  end
  $cache[i] = 1
  1
end

joltage_adapters.insert(0, 0)
puts combinations 0, joltage_adapters

# test = []
# open('test_input.txt').each do |line|
#   jolts = line.to_i
#   insert_at = test.bsearch_index { |j| j >= jolts } || -1
#   test.insert(insert_at, jolts)
# end
# test.insert(0, 0)
# puts test
# puts combinations 0, test
