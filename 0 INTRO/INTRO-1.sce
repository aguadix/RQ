clear; // Borra variables
clc;   //  Limpia consola
// INTRO-1.sce
// RESOLUCIÓN NUMÉRICA DE UN SISTEMA DE ECUACIONES ALGEBRAICAS

// Sistema de ecuaciones algebraicas
function y = f(x)
  y(1) = x(1)^2 + x(2)^2 - 1
  y(2) = x(1)^2 - x(2)
endfunction

// Gráfica
scf(1); // Configura ventana gráfica
clf(1); // Limpia ventana gráfica
t = 0:0.001:1; x1 = cos(2*%pi*t); x2 = sin(2*%pi*t); plot(x1,x2); // Dibuja f1(x)=0
x1 = -1:0.001:1; x2 = x1^2; plot(x1,x2); // Dibuja f2(x)=0
xgrid; // Cuadrícula
xtitle('INTRO-1','x1','x2'); // Títulos

// Solución supuesta
xguess = [0.5;0.5];  
plot(xguess(1),xguess(2),'ro');


// (a) MÉTODO DE NEWTON

// Jacobiano
function dfdx = J(x)   
  dfdx(1,1) = 2*x(1) 
  dfdx(1,2) = 2*x(2)
  dfdx(2,1) = 2*x(1)
  dfdx(2,2) = -1
endfunction

x = xguess; // Solución de partida
imax = 50;  // Número máximo de iteraciones
tol = 1E-6; // Tolerancia

for i = 1:imax
  i
  x = x - inv(J(x))*f(x)      // Fórmula
  plot(x(1),x(2),'ro'); xnumb(x(1), x(2), i);
  if abs(f(x)) < tol then
    break   // Salir del bucle si se rebaja la tolerancia 
  end
end
fx = f(x)  // Valor de la función en la solución


// (b) FUNCIÓN DE SCILAB - fsolve 
[x,fx,info] = fsolve(xguess,f)
plot(x(1),x(2),'rx');
