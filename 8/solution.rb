require 'set'

instructions = open('input.txt').read.split("\n")
acc = 0
which_op = 0
keep_trying = true
while keep_trying
  pointer = 0
  operations_to_wait = which_op
  acc = 0
  visited = Set[]
  while true
    if visited.include? pointer
      puts "repeated: #{pointer}"
      break
    end
    visited << pointer
    if pointer > instructions.length || pointer < 0
      puts "out of bounds: #{pointer}!"
      break
    end
    if pointer == instructions.length
      puts "ended naturally!"
      keep_trying = false
      break
    end
    instruction = instructions[pointer]
    if instruction
      instruction = instruction.split(" ")
      action = instruction[0].strip
      value = instruction[1].strip.to_i
      if action == 'nop' || action == 'jmp'
        if operations_to_wait == 0
          puts "SWITCH #{instructions[pointer]}"
          if action == 'nop'
            action = 'jmp'
          else
            action = 'nop'
          end
        end
        operations_to_wait -= 1
      end
      if action == 'acc'
        acc += value
      elsif action == 'jmp'
        pointer += (value - 1)
      elsif action == 'nop'
        # do nothing
      else
        puts "unrecognized action: #{action}"
      end
    else
      puts "instruction returned nil"
      break
    end
    pointer += 1
  end

  which_op += 1
end
puts "which_op to switch = #{which_op - 1}"
puts acc

