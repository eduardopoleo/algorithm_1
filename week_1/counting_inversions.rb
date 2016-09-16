#brute force
  #double for which is O(n2)

# but we can do better than that.
a = [10, 9, 8, 7, 6, 5]

file = File.open('data_set.txt', 'r')
lines = file.readlines
file.close

b = []

lines.each do |l|
  l.chomp!
  b << l
end

b = b.map(&:to_i)

p b

def sort_and_count(a)
  return [a, 0] if a.length == 1

  length = a.length

  b, x = sort_and_count(a[0...length/2])
  c, y = sort_and_count(a[length/2..-1])

  # This is the hard part because there might even be quadratic number of split
  # inversions but we still need to count them with n to make the whole algorithm
  # nlog
  d, z = mergesort_and_count_split(b, c)

  return [d, x + y + z]
end


def mergesort_and_count_split(a, b)
  result = []
  count = 0

  while !a.empty? && !b.empty? do #1
    if a[0] < b[0] #
      result << a.delete_at(0)
    else
      count += a.length
      result << b.delete_at(0)
    end
  end

  if !a.empty?
    result += a
  elsif !b.empty?
    result += b
  end

  [result, count]
end

p sort_and_count(b)
