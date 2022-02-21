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
