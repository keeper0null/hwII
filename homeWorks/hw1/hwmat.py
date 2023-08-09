# -*- coding: utf-8 -*-
"""hwMat.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1tNfuKDGLVA5jEyMjXfu0tneAbwtUVr92

# Формулировка задания
Решить задачи по высшей математике:

Решить матрицы:

$$
\left(\begin{array}{cc}
6 & -8 & 3
\end{array}\right) *
\left(\begin{array}{cc}
1 \\
1 \\
4
\end{array}\right) =
\left(\begin{array}{cc}
0
\end{array}\right)
$$

$$
\left(\begin{array}{cc}
-3 & -7 \\
-10 & 6 \\
0 & -6 \\
-1 & -3
\end{array}\right) *
\left(\begin{array}{cc}
-8 & 9 \\
4 & -2
\end{array}\right) =
\left(\begin{array}{cc}
0 & 0 \\
0 & 0 \\
0 & 0 \\
0 & 0
\end{array}\right)
$$

## Решение с использованием библиотеки:
"""

#подключаем библиотеку
import numpy as np

A = np.matrix([[6, -8, 3]])
B = np.matrix([[1],
               [1],
               [4]])
print(A * B)

C = np.matrix([[ -3,  -7],
               [-10,   6],
               [  0,  -6],
               [ -1,  -3]])

D = np.matrix([[ -8,   9],
               [  4,  -2]])
print(C * D)

"""## Решение с использованием циклов"""

def multiply(A, B):
  '''
  Функция умножения
  @param A - матрица 1 m на n
  @param B - матрица 1 n на k
  @returns результат умножения
  '''
  m = len(A)                                            # a: m × n
  n = len(B)                                            # b: n × k
  k = len(B[0])

  result = [[None for __ in range(k)] for __ in range(m)]    # result: m × k
  for i in range(m):
    for j in range(k):
        result[i][j] = sum(A[i][kk] * B[kk][j] for kk in range(n))
  return result

a = [[6, -8, 3]]

b =  [[1],
      [1],
      [4]]

print(multiply(a, b))

c =[[ -3,  -7],
    [-10,   6],
    [  0,  -6],
    [ -1,  -3]]

d = [[ -8,   9],
     [  4,  -2]]

print(multiply(c, d))