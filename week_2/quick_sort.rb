#high overview

a = [3,8,2,5,1,4,7,6]
require 'pry'

def quick_sort(a, lo, hi)
  return a if lo == hi

  i = random_linear_partitioning(a, lo, hi)

  quick_sort(a, lo, i - 1)
  quick_sort(a, i, hi)
  # This works because the changes are done in place and there is no need to
  # merge the arrays into one.
end

def linear_partitioning(a, lo, hi)
  pivot = a[lo]
  # the concept of i is one after the pivot to start looking after it. 
  i = lo + 1

  for j in lo...hi
    if a[j] < pivot
      element_to_swap = a[i]
      a[i] = a[j]
      a[j] = element_to_swap
      i += 1
    end
  end

  element_to_swap = a[i - 1] # I gotta remember that this is just a swap nothing else
  a[i - 1] = a[lo]
  a[lo] = element_to_swap

  i
end

def random_linear_partitioning(a, lo, hi)
  pivot_index = rand(lo...hi)

  pivot = a[pivot_index]
  a[pivot_index] = a[lo]
  a[lo] = pivot

  i = lo + 1

  for j in lo...hi
    if a[j] < pivot
      element_to_swap = a[i]
      a[i] = a[j]
      a[j] = element_to_swap
      i += 1
    end
  end

  element_to_swap = a[i - 1] # I gotta remember that this is just a swap nothing else
  a[i - 1] = a[lo]
  a[lo] = element_to_swap

  i
end

sorted_array = quick_sort(a, 0, 8)

p sorted_array
