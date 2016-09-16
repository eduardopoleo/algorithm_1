def merge(all_arrays)
  k = all_arrays.length
  n = all_arrays[0].length

  result = []

  for i in 0...k
    for j in 0...n
      result << all_arrays[k][j]
    end
  end

  result
end

N = 10

def a
  2**(2**N)
end


def b
  2**(N**2)
end

def c
  N**2*Math.log(N)
end

def d
  N
end

def e
  N**(2**N)
end

puts "a: #{a}"
puts "b: #{b}"
puts "c: #{c}"
puts "d: #{d}"
puts "e: #{e}"

#d < c < b < a < e
