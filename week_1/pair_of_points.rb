points = [[1,2], [3,4], [5,6]]

#This will be the idea for a n^2 algorithm
for i in 0...points.lentgh
  for j in i+1...points.length
    (points[i][0] - points[j][0]) + (points[i][1] - points[j][1])
  end
end


# for a sorted 1-D  array find the closest pair.

a = [3,6,10,11, 18, 22]
# if the array was not sorted this would also be an N2 problem
# n times
for i in 0...a.length - 1
   diff = a[i+1] - a[i]
   #max check
end
# Ordering the points:
# Higher view of the algorimth

def main(points) # array with all the points
  #copy of the array by an especific cordinate
  #nlogn
  # This is a primitive, aka operations that are costless compared to the
  # total complexity we are aming for
  px = sort_by_cordinate(points, 0)
  py = sort_by_cordinate(points, 1)

  result = closest_pair(px, py)
end

def closest_pair(px, py)
  #### BASE CASE ###
  length = px.length
  q = px[0...length/2]
  r = px[length/2..-1]

  # this apparently can be done in linear time... becuase we have the the corresponding px and py
  qx = quick_sort_by_cordinate(px, q, 0)
  qy = quick_sort_by_cordinate(py, q, 1)
  rx = quick_sort_by_cordinate(px, r, 0)
  ry = quick_sort_by_cordinate(py, r, 1)

  closest_pair_right = closest_pair(qx, qy)
  closest_pair_left = closest_pair(rx, ry)
  #calculates the minimum delta between among the pair on the right and the pair on the left
  delta = calculate_delta(closest_pair_left, closest_pair_right)

  split_pair = closest_split_pair(px, py, delta)

  result = best_pair(closest_pair_left, closest_pair_right, split_pair)
end


def closest_split_pair(px, py, delta)
  # x_var is the middle x coordinate
  x_var # easy to figure out cus px is sorted px[lenthg/2] sort of
  sy = calculate_points_that_are_within_band_sorted_by_y

  best = delta
  best_pair = []
  
  for i in 0...sy.length - 7
    for j in 0..7
      point1 = sy[i]
      point2 = sy[i + j]
      if d(point1, point2) < best
        best_pair = [point1, point2]
        best = d(point1, point2)
      end
    end
  end
end
