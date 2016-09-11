# Way 1
# 1. Recursively get to sorted arrays A, B
# 2. Merging into C by progresively comparing A[i], B[k]

#Implement Merge sort
require 'pry'
input = [11, 8, 9 , 4, 5, 7, 3, 10]

def mergesort(input)
  return input if input.length < 2

  half_index = input.length / 2

  half1 = input[0...half_index]
  half2 = input[half_index..-1]

  a = mergesort(half1)
  b = mergesort(half2)

  merge(a, b)
end

def merge(a, b)
  result = []

  while !a.empty? && !b.empty? do #1
    if a[0] < b[0] #
      result << a.delete_at(0)
    else
      result << b.delete_at(0)
    end
  end

  if !a.empty?
    result += a
  elsif !b.empty?
    result += b
  end

  result
end

#This algorith is broken cus ruby can compare nils to integers
#It makes sense to remove elements but:
  # do not depend on indexes
  # remove until the first one is depleted, again to avoid problems with nil

def merge2(a,b)
  result = []
  length = a.length + b.length
  i = 0
  j = 0

  for k in 0...length do  #1
    if a[i] < b[j] #
      result[k] = a[i]
      i += 1
    elsif b[j] < a[i]
      result[k] = b[j]
      j += 1
    end
  end

  if a.length > b.length
    result += a
  elsif b.length < a.length
    result += b
  end

  result
end

p mergesort(input)

# Big Oh notations
  # T(n) = O(Fn)
# T(n) is the algorith complexity
# Fn is the upper bound
# Then Fn is the upper bound if
    #T(n) <= c * Fn

  # for all n >= no

  #O(Fn) <= c * Fn
# For all n > no c * Fn will always be bigger than T(n). O is just a confusing thing
