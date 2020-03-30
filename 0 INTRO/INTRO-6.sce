clear; clc;
// INTRO-6.sce
// LINEALIZACIÓN DE UN SISTEMA NO LINEAL ALREDEDOR DE UN ESTADO ESTACIONARIO

// Sistema no lineal
function dxdt = f(x)
    // dx1dt = f1(x1,x2)
    // dx2dt = f2(x1,x2)
    dxdt(1) = x(1)^2 + x(2)^2 - 1
    dxdt(2) = x(1)^2 - x(2)
endfunction

// Cálculo numérico del estado estacionario
// f1(x1,x2) = 0
// f2(x2,x2) = 0 
xeeguess = [0.5;0.5];  // Solución supuesta
[xee,fxee,info] = fsolve(xeeguess,f)

// Desarrollo en serie de Taylor
// dx1dt = f1(x1ee,x2ee) + df1dx1ee*(x1-x1ee) + df1dx2ee*(x2-x2ee) + ...
// dx2dt = f2(x1ee,x2ee) + df2dx1ee*(x1-x1ee) + df2dx2ee*(x2-x2ee) + ...

// Definición de variables de desviación
// x1d = x1 - x1ee  => dx1ddt = dx1dt
// x2d = x2 - x2ee  => dx2ddt = dx2dt

// dx1ddt = df1dx1ee*x1d + df1dx2ee*x2d
// dx2ddt = df2dx1ee*x1d + df2dx2ee*x2d
// dxddt  = A*xd  (SISTEMA LINEAL)

// A = [df1dx1ee  df1dx2ee
//      df2dx1ee  df2dx2ee]   (JACOBIANO)

A = numderivative(f,xee)

// Punto de prueba
x0 = xee*(1+1E-3)

// Derivadas exactas (sistema no lineal)
dxdt0 = f(x0)
 
// Derivadas aproximadas (sistema linealizado)
xd0 = x0 - xee;
dxddt0 = A*xd0

Error = (dxddt0-dxdt0)./dxdt0
