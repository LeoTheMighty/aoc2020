def index_of_end_paren(str, open_paren)
  puts "WTF" if str[open_paren] != '('
  i = open_paren
  stack = 0
  while i < str.length
    c = str[i]
    if c == '('
      stack += 1
    elsif c == ')'
      stack -= 1
      return i if stack == 0
    end
    i += 1
  end
  puts "WTF 2"
end

def perform(answer, value, operation)
  return answer + value if operation == '+'
  answer * value if operation == '*'
end

def compute(str)
  answer = 0
  operation = '+'
  i = 0
  while i < str.length
    c = str[i]
    if c != ' '
      # go through
      if c == '('
        end_paren = index_of_end_paren str, i
        value = compute(str[i+1..end_paren-1])
        answer = perform answer, value, operation
        i = end_paren
      elsif c == ')'
        puts 'WTF 3'
      elsif c == '+'
        operation = '+'
      elsif c == '*'
        operation = '*'
      elsif c.to_i
        answer = perform answer, c.to_i, operation
      end
      # c.to_i
    end
    i += 1
  end
  answer
end

sum = 0
open('input.txt').each do |line|
  answer = compute line.strip
  puts "#{line} = #{answer}"
  sum += answer
end
puts sum
