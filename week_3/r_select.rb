require 'pry'

def r_select(a, i)
  return a[0] if a.length == 1

  pivot_index = choose_pivot(a.length)

  a, new_pivot_index = linear_partitioning(a, pivot_index)
  return a[new_pivot_index] if new_pivot_index == i

  new_a, new_i = slice_array(a, new_pivot_index, i)

  r_select(new_a, new_i)
end

def choose_pivot(n)
  rand(0...n)
end


def linear_partitioning(a, pivot_index)
  length = a.length
  pivot = a[pivot_index]
  a = swap(a, pivot_index, 0)

  i = 1
  for j in 0...length
    if a[j] < pivot
      swap(a, j, i)
      i += 1
    end
  end

  a = swap(a, 0, i - 1)

  [a, i - 1]
end

def slice_array(a, new_pivot_index, i)
  if new_pivot_index > i
    a = a.slice(0...new_pivot_index)
  else
    a = a.slice(new_pivot_index + 1..-1)
    i = i - new_pivot_index
  end
  [a, i]
end

def swap(a, init, final)
  a[init], a[final] = a[final], a[init]

  a
end


a = [1,2,3,4,5,6,7,8]

p r_select(a, 5)
