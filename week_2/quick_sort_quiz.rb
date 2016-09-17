require 'pry'
file = File.open('data_set.txt', 'r')
lines = file.readlines
file.close

b = []

lines.each do |l|
  l.chomp!
  b << l
end

b = b.map(&:to_i)

def quick_sort_2(a, lo, hi)
  return [a, 0] if lo > hi

  i, x = linear_partitioning(a, lo, hi)

  a, y = quick_sort_2(a, lo, i - 1)
  a, z = quick_sort_2(a, i + 1, hi)

  [a, x + y + z]
end

def linear_partitioning(a, lo, hi)
  pivot_index = calculate_pivot(a, lo, hi)
  pivot = a[pivot_index]
  swap(a, pivot_index, lo)

  m = lo + 1

  for j in lo..hi
    if a[j] < pivot
      swap(a, j, m)
      m += 1
    end
  end

  swap(a, m - 1, lo)

  count = a.slice(lo...hi).size

  [m - 1, count]
end

def swap(a, i, j)
  element_to_swap = a[i]
  a[i] = a[j]
  a[j] = element_to_swap

  a
end

# Question 3
def calculate_pivot(a, lo, hi)
  first = a[lo]
  last = a[hi]

  new_a = a.slice(lo..hi)

  if new_a.size.even?
    middle_index = new_a.size/2 - 1 + lo
  else
    middle_index = new_a.size/2 + lo
  end

  middle = a[middle_index]

  z = [first, middle, last].sort

  case z[1]
  when first
    lo
  when middle
    middle_index
  when last
    hi
  end
end

p quick_sort_2(b, 0, 9999)

__END__
Results:
lo: 162085
hi: 164123
me: 138382
