def quick_sort_2(a, lo, hi)
  # if at some point everyting will be sorted and nothing will get moved and m - 1 = 0
  # when this happens lo = 0, i -1 = -1
  # this obviously is not right can be used for iteration
  # it's better to leave this condition till the end to reason about it
  return a if lo > hi

  # i is the position of the element right in front of the pivot
  i = linear_partitioning(a, lo, hi)

  quick_sort_2(a, lo, i - 1 )
  quick_sort_2(a, i + 1, hi)
end

def linear_partitioning(a, lo, hi)
  pivot_index = rand(lo..hi)
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

  m - 1
end

def swap(a, i, j)
  element_to_swap = a[i]
  a[i] = a[j]
  a[j] = element_to_swap

  a
end

a = [3,8,2,5,1,4,7,6]

p quick_sort_2(a, 0, 7)
