DIVIDE = 20201227

keys = open('input.txt').read.split("\n")
$card_public_key = keys[0].to_i
$door_public_key = keys[1].to_i

def transform(subject_number, loop_times)
  n = 1
  loop_times.times do
    n *= subject_number
    n %= DIVIDE
  end
  n
end

def find_loop_times(subject_number, target)
  n = 1
  i = 0
  while n != target
    n *= subject_number
    n %= DIVIDE
    i += 1
  end
  i
end

card_loop_times = 6041183
door_loop_times = 8306869
puts transform($door_public_key, card_loop_times)
# puts find_loop_times(7, $door_public_key)
# door_loop_times = 1
# while transform(7, door_loop_times) != $door_public_key
#   door_loop_times += 1
# end
# puts transform($card_public_key, door_loop_times)
