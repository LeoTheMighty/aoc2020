rules = {} # num -> rule
sections = open('input-update.txt').read.split("\n\n")

sections[0].split("\n").each do |line|
  parts = line.split(":")
  num = parts[0].to_i
  rule_str = parts[1].strip
  if rule_str[0] == "\""
    rule = rule_str[1..-2]
  elsif rule_str.include? "|"
    parts = rule_str.split("|")
    rule = []
    parts.each do |part|
      r = []
      part.split(" ").each do |p|
        r << p.to_i
      end
      rule << r
    end
  else
    rule = []
    rule_str.split(" ").each do |p|
      rule << p.to_i
    end
    rule = [rule]
  end

  rules[num] = rule
end

puts rules
# aabbaba
#

def construct_regex_str(rules, rule)
  if rule == 8
    s42 = construct_regex_str(rules, 42)
    to = 10
    s = '('
    1.upto(to) do |i|
      s << "#{s42 * i}"
      if i != to
        s << '|'
      end
    end
    s << ')'
    return s
  elsif rule == 11
    s42 = construct_regex_str(rules, 42)
    s31 = construct_regex_str(rules, 31)
    s = '('
    to = 10
    1.upto(to) do |i|
      s << "#{s42 * i}#{s31 * i}"
      if i != to
        s << '|'
      end
    end
    s << ')'
    return s
    # return "(#{s42}#{s31}|#{s42 * 2}#{s31 * 2}|#{s42 * 3}#{s31 * 3}|#{s42 * 4}#{s31 * 4}|#{s42 * 5}#{s31 * 5}|#{s42 * 6}#{s31 * 6})"
  end
  r = rules[rule]
  if r == "a" || r == "b"
    return r
  end
  s = '('
  r.each_with_index do |p, i|
    p.each do |r1|
      s << "#{construct_regex_str(rules, r1)}"
    end
    if i != r.length - 1
      s << '|'
    end
  end
  s << ')'
  s
end

def satisfies_rule(rules, rule, str)
  regex_str = construct_regex_str(rules, rule)
  regex = Regexp.new(regex_str)
  v = regex.match(str).to_s == str
  puts "#{str} => #{regex_str} ? #{v}"
  v
end

num_satisfy = 0
sections[1].split("\n").each do |line|
  num_satisfy += 1 if satisfies_rule(rules, 0, line.strip)
end
puts num_satisfy
