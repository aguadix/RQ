clear; clc;
// SCILAB-2.sce

// Funciones

// 2 entradas, 4 salidas

function [s,r,m,d] = f(a,b)
  s = a+b
  r = a-b
  m = a*b
  d = a/b
endfunction

a = 6;
b = 2;
[s,r,m,d] = f(a,b) 


// Sucesión de Fibonacci

function v = fib(n)
  v(1) = 0;
  v(2) = 1;
  for i = 3:n
    v(i) = v(i-1) + v(i-2)
  end
endfunction

n = 10;
v = fib(n)

// Multiplicación de matrices

function C = mmult(A,B)
  [m,n] = size(A)
  [n,p] = size(B)
  for i = 1:m
    for j = 1:p
      C(i,j) = sum(A(i,:).*B(:,j)')
    end
  end
endfunction

A = [1 -1 3; 3 0 1]
B = [2 0; 2 1; 1 -1]
C = mmult(A,B)

// Cambios de signo en un vector

function indexcs1 = cs1(v)
  for i = 1:length(v)-1
    if v(i)*v(i+1) < 0 then
      indexcs1($+1) = i+1
    end
  end
endfunction

v = [1 3 5 -1 1 2 7 2 -2]
indexcs1 = cs1(v)

// Cambios de signo en un vector (alternativa)

function indexcs2 = cs2(v)
  indexcs2 = find(v(1:$-1).*v(2:$)<0) + 1
endfunction

indexcs2 = cs2(v)
