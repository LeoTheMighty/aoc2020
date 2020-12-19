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
  operation = '+'
  i = 0
  computed_tokens = []
  while i < str.length
    c = str[i]
    if c != ' '
      # go through
      if c == '('
        end_paren = index_of_end_paren str, i
        value = compute(str[i+1..end_paren-1])
        computed_tokens << value
        i = end_paren
      elsif c == ')'
        puts 'WTF 3'
      elsif c == '+'
        computed_tokens << c
      elsif c == '*'
        computed_tokens << c
      elsif c.to_i
        computed_tokens << c.to_i
      end
      # c.to_i
    end
    i += 1
  end
  # do addition
  (computed_tokens.length - 1).downto(0) do |i|
    t = computed_tokens[i]
    if t == '+'
      v1 = computed_tokens.delete_at i + 1
      computed_tokens.delete_at i
      computed_tokens[i - 1] += v1
    end
  end
  # do multiplication
  answer = 1
  computed_tokens.each { |t| answer *= t if t != '*' }
  answer
end

sum = 0
open('input.txt').each do |line|
  answer = compute line.strip
  puts "#{line} = #{answer}"
  sum += answer
end
puts sum
