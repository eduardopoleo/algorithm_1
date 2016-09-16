# brute force algoright

a = [[1,2], [3,4]] # outer = r , inner = c = i

b = [[5,6], [7,8]]  # outer = f = j , inner = c

require 'Matrix'

def matrix_mult(a, b)
  n = a.length
  c = Matrix.zero(n).to_a

  for i in 0...n
    for j in 0...n
      for k in 0...n
        c[i][j] = c[i][j] + a[i][k] * b[k][j]
      end
    end
  end
  c
end


p matrix_mult(a,b)
