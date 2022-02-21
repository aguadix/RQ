clear; clc;
// SCILAB-2.sce

// Funciones

// Seno como suma infinita

function y = sine(x,N)
  n = 1:N
  y = sum((-1)^(n-1)./factorial(2*n-1).*x^(2*n-1))
endfunction

x = %pi/4;
N = 10;
y = sine(x,N)


// Sucesión de Fibonacci

function v = fib(n)
  v(1) = 1;
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
