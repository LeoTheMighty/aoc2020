def to_binary(n)
  n.to_s(2)
end

def to_integer(b)
  b.to_i(2)
end

def apply_mask(n, mask)
  # go backwards
  b = to_binary n
  b = "0" * (mask.length - b.length) + b
  1.upto(mask.length) do |i|
    v = mask[-1 * i]
    if v == '0' || v == '1'
      b[-1 * i] = v
    end
  end
  to_integer b
end

def get_all_addresses(addr, mask, start = 1)
  mask = mask.dup
  b = to_binary addr
  b = "0" * (mask.length - b.length) + b
  start.upto(mask.length) do |i|
    v = mask[-1 * i]
    mask[-1 * i] = '0'
    if v == '1'
      b[-1 * i] = v
    elsif v == 'X'
      b1 = b.clone
      b2 = b.clone
      b1[-1 * i] = '1'
      b2[-1 * i] = '0'
      return get_all_addresses(to_integer(b1), mask, i + 1) + get_all_addresses(to_integer(b2), mask, i + 1)
    end
  end
  [to_integer(b)]
end

mask = ''
mem = {}
mem2 = {}
open('input.txt').each do |line|
  if line.split(" ")[0] == 'mask'
    # set the mask
    mask = line.split(" ")[2].strip()
  else
    addr = line.split(" ")[0][4..-2].to_i
    value = line.split(" ")[2].to_i
    mem[addr] = apply_mask value, mask

    get_all_addresses(addr, mask).each do |address|
      mem2[address] = value
    end
  end
end
sum = 0
mem.each do |k, v|
  sum += v
end
puts sum
sum = 0
mem2.each do |k, v|
  sum += v
end
puts sum
