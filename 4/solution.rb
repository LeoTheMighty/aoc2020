require 'set'

PASSPORT_FIELDS = Set["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"]

def get_input_hashs
  hashs = []
  file = open('input.txt')
  file.read.split("\n\n").each do |section|
    i = 1
    object = {}
    section.split(/[ \n]/).each do |field|
      field = field.strip
      # puts "    #{i}. \"#{field}\""
      hash_parts = field.split(':')
      object[hash_parts[0]] = hash_parts[1]
      i += 1
    end
    # puts
    hashs << object
  end
  hashs
end

def field_is_valid(key, value)
  begin
    case key
    when "byr"
      return Integer(value) >= 1920 && Integer(value) <= 2002
    when "iyr"
      return Integer(value) >= 2010 && Integer(value) <= 2020
    when "eyr"
      return Integer(value) >= 2020 && Integer(value) <= 2030
    when "hgt"
      num = Integer(value[0..-3])
      unit = value[-2..]
      if unit == 'in'
        return num >= 59 && num <= 76
      elsif unit == 'cm'
        return num >= 150 && num <= 193
      else
        return false
      end
    when "hcl"
      return false unless value[0] == '#'
      value[1..].each_char do |c|
        return false unless ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'].include? c
      end
    when "ecl"
      return ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'].include? value
    when "pid"
      return false unless value.length == 9
      value.each_char do |c|
        return false unless ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'].include? c
      end
    when "cid"
      # do nothing
    else
      return false
    end
  rescue
    return false
  end
  true
end

def passport_is_valid(passport_hash)
  fields = Set[]
  passport_hash.each do |key, value|
    unless field_is_valid(key, value)
      puts "#{key} FAILED #{value}"
      return false
    end
    fields.add(key)
  end
  missing = PASSPORT_FIELDS - fields
  if missing.empty? || (missing.length == 1 && missing.to_a[0] == 'cid')
    return true
  end
  false
end



valids = 0
get_input_hashs.each do |hash|
  if passport_is_valid(hash)
    valids += 1
  else
    puts "FAILED: #{hash}"
  end
end
puts valids

# test = {"ecl"=>"grn", "cid"=>"89", "hgt"=>"193cm", "pid"=>"73793987", "iyr"=>"2021", "eyr"=>"2027", "byr"=>"1939", "hcl"=>"z"}
# test = {"cid"=>"151", "hcl"=>"#c0946f", "ecl"=>"brn", "hgt"=>"66cm", "iyr"=>"2013", "pid"=>"694421369", "byr"=>"1980", "eyr"=>"2029"}
# puts passport_is_valid(test)
