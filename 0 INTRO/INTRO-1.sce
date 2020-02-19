clear; clc;
// INTRO-1.sce

// Sistema de ecuaciones algebraicas
function y = f(x)
  y(1) = x(1)^2 + x(2)^2 - 1
  y(2) = x(1)^2 - x(2)
endfunction

scf(1); clf(1);// Configura y limpia la ventana gráfica
xgrid; xtitle('INTRO-1.','t','x'); // Cuadrícula y títulos

t = 0:0.01:1; xc = cos(2*%pi*t); yc = sin(2*%pi*t); plot(xc,yc); // Círculo
xp = -1.5:0.1:1.5; yp = xp^2; plot(xp,yp);  // Parábola

xguess = [0.5;0.5];  // Solución supuesta
plot(xguess(1),xguess(2),'ro')

// (a) MÉTODO DE NEWTON
x = xguess; // Solución de partida
imax = 50;  // Número máximo de iteraciones
tol = 1E-6; // Tolerancia

for i = 1:imax
  i
  J = numderivative(f,x);  // Jacobiano
  x = x - inv(J)*f(x)      // Fórmula
  plot(x(1),x(2),'ro'); xnumb(x(1), x(2), i);
  if abs(f(x)) < tol then
    break                  // Salir del bucle si se rebaja la tolerancia 
  end
end
f(x)  // Valor de la función en la solución


// (b) FUNCIÓN DE SCILAB - fsolve 
[x,fx,info] = fsolve(xguess,f)
