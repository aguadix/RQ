clear; // Borra variables
clc;   //  Limpia consola
// INTRO-3.sce
// CÁLCULO NUMÉRICO DE LA MATRIZ JACOBIANA

// Función multivariable
function y = f(x)
    y(1) = x(1)^2*sin(x(2))
    y(2) = x(1)*x(2)^3
endfunction

// J = [df1dx1ee  df1dx2ee
//      df2dx1ee  df2dx2ee]

// Punto de prueba
x0 = [1;%pi/4];
fx0 = f(x0)

// (a) Analítico
function dfdx = J(x)
    dfdx(1,1) = 2*x(1)*sin(x(2))
    dfdx(1,2) = x(1)^2*cos(x(2))
    dfdx(2,1) = x(2)^3
    dfdx(2,2) = 3*x(1)*x(2)^2
endfunction

Jx0 = J(x0)


// (b) Numérico
h = 1E-6;
function y = Jac(x)
    y(1) = (f([x(1)+h,x(2)]) - f([x(1),x(2)])) / h
    y(2) = (f([x(1),x(2)+h]) - f([x(1),x(2)])) / h
endfunction

Jx0 = J(x0)

// (c) Scilab
Jx0 = numderivative(f,x0)
