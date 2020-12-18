input = [0,13,1,16,6,17]
# input = [0,3,6] # TODO TEST

i = 1
said = {}
last_was_new = false
last_said = -1
while i < 30000001
  index = i - 1
  if index < input.length
    currently_said = input[index]
  elsif last_was_new
    currently_said = 0
  else
    currently_said = said[last_said][-1] - said[last_said][-2]
  end
  # puts "Turn #{i}: \"#{currently_said}\""
  last_was_new = !said.has_key?(currently_said)
  unless said.has_key?(currently_said)
    last_was_new = true
    said[currently_said] = []
  end
  said[currently_said] << i
  last_said = currently_said
  i += 1
end

puts last_said
