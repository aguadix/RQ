clear; clc;
// INTRO-3.sce 
// CÁLCULO NUMÉRICO DE LA MATRIZ JACOBIANA

// J = [df1dx1  df1dx2
//      df2dx1  df2dx2]

// Función multivariable
function y = f(x)
    y(1) = x(1)^2*sin(x(2))
    y(2) = x(1)*x(2)^3
endfunction

// Punto de prueba 
x = [1;%pi/4];
fx = f(x)

// (a) Analítico
function dfdx = Ja(x)
    dfdx(1,1) = 2*x(1)*sin(x(2))
    dfdx(1,2) = x(1)^2*cos(x(2))
    dfdx(2,1) = x(2)^3
    dfdx(2,2) = 3*x(1)*x(2)^2
endfunction

Jax = Ja(x)

// (b) Numérico
dx = [1E-6 1E-6]
function dfdx = Jn(x)
    dfdx(:,1) = (f([x(1)+dx(1),x(2)])       - f([x(1),x(2)])) / dx(1)
    dfdx(:,2) = (f([x(1)      ,x(2)+dx(2)]) - f([x(1),x(2)])) / dx(2)
endfunction

Jnx = Jn(x)

// (c) Scilab
Jx = numderivative(f,x) 
