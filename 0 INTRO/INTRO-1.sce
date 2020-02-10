clear; clc;
// INTRO-1.sce

// Sistema de ecuaciones algebraicas
function y = f(x)
  y(1) = x(1)^2 + x(2)^2 - 1
  y(2) = x(1)^2 - x(2)
endfunction

xguess = [0.5;0.5];  // Valor supuesto para la solución


// (a) MÉTODO DE NEWTON
x = xguess; // Solución inicial
imax = 50;  // Número máximo de iteraciones
tol = 1E-6; // Tolerancia

for i = 1:imax
  i
  J = numderivative(f,x);  // Jacobiano
  x = x - inv(J)*f(x)      // Fórmula  
  if abs(f(x)) < tol then
    break                  // Salir del bucle si se rebaja la tolerancia 
  end
end
f(x)  // Valor de la función en la solución


// (b) FUNCIÓN DE SCILAB - fsolve 
[x,fx,info] = fsolve(xguess,f)
 