def quick_sort_2(a, lo, hi)
  # there can't be iteration if lo == hi
  return a if lo == hi

  # i is the position of the element right in front of the pivot
  i = linear_partitioning(a, lo, hi)

  quick_sort_2(a, lo, i - 1)
  quick_sort_2(a, i, hi)
end


def linear_partitioning(a, lo, hi)
  pivot_index = rand(lo...hi)
  pivot = a[pivot_index]
  swap(a, pivot_index, lo)

  #i by definition is always one extra place than the pivot
  i = lo + 1

  for j in lo...hi
    if a[j] < pivot
      swap(a, j, i)
      i += 1
    end
  end

  swap(a, i-1, lo)

  i
end

def swap(a, i, j)
  element_to_swap = a[i]
  a[i] = a[j]
  a[j] = element_to_swap

  a
end

a = [3,8,2,5,1,4,7,6]

p quick_sort_2(a, 0, 8)
