clear; clc; 
// INTRO-2.sce
// RESOLUCIÓN NUMÉRICA DE UN SISTEMA DE ECUACIONES DIFERENCIALES

// Sistema de ecuaciones diferenciales
function dxdt = f(t,x)
  dxdt(1) = -c(1)*x(1)
  dxdt(2) = c(1)*x(1) - c(2)*x(2)
  dxdt(3) = c(2)*x(2)
endfunction

c = [1 2];  // Constantes
xini = [1;0;0]  // Condiciones iniciales (valores a tiempo cero)
dt = 0.1; tfin = 10; t = 0:dt:tfin;  // Vector de tiempo


// (a) MÉTODO. DE EULER

x(:,1) = xini;  // Colocar las condiciones iniciales en la primera columna

for i = 1:length(t)-1
  x(:,i+1) = x(:,i) + dt * f(t(i),x(:,i));  // Fórmula
end

scf(1); clf(1);// Configura y limpia la ventana gráfica
plot(t,x,'o');   // Gráfica
xgrid; xlabel('t');


// (b) MÉTODO. RK4

x(:,1) = xini;  // Colocar las condiciones iniciales en la primera columna

for i = 1:length(t)-1
  k1 = dt * f(t(i),x(:,i)); 
  k2 = dt * f(t(i)+dt/2,x(:,i)+k1/2); 
  k3 = dt * f(t(i)+dt/2,x(:,i)+k2/2);
  k4 = dt * f(t(i)+dt,x(:,i)+k3); 
  x(:,i+1) = x(:,i) + 1/6 * (k1+2*k2+2*k3+k4);  // Fórmula
end

plot(t,x,'.'); // Gráfica


// (c) FUNCIÓN DE SCILAB - ode

x = ode(xini,0,t,f);
plot(t,x,'-'); // Gráfica 

legend('x1 EULER','x2 EULER','x3 EULER','x1 RK4','x2 RK4','x3 RK4','x1 ode','x2 ode','x3 ode',-2,%f);


