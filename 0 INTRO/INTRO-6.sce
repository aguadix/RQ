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

// Punto de prueba
x = xee*(1+1E-2)

// Derivadas exactas (sistema no lineal)
dxdt = f(x)

// Desarrollo en serie de Taylor
// dx1dt = f1(x1ee,x2ee) + df1dx1ee*(x1-x1ee) + df1dx2ee*(x2-x2ee) + ...
// dx2dt = f2(x1ee,x2ee) + df2dx1ee*(x1-x1ee) + df2dx2ee*(x2-x2ee) + ...

// Definición de variables de desviación
// xd  = x  - xee;
// x1d = x1 - x1ee  => dx1ddt = dx1dt
// x2d = x2 - x2ee  => dx2ddt = dx2dt
xd = x - xee

// dx1ddt = df1dx1ee*x1d + df1dx2ee*x2d
// dx2ddt = df2dx1ee*x1d + df2dx2ee*x2d

// J = [df1dx1ee  df1dx2ee
//      df2dx1ee  df2dx2ee]   (JACOBIANO)
J = numderivative(f,xee)

// Derivadas aproximadas (sistema linealizado)
dxddt = J*xd

Error = (dxddt-dxdt)./dxdt
