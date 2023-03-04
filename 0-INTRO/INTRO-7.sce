clear; clc;
// INTRO-7.sce
// PÉNDULO AMORTIGUADO

// Sistema de ecuaciones diferenciales
function dxdt = f(t,x)
    // Variables diferenciales
    A = x(1)   // Ángulo
    W = x(2)   // Velocidad angular
    // Segunda Ley de Newton
    // d2Adt2 = -b*dAdt - g/L*sin(A)
    dAdt = W
    dWdt = -b*W - g/L*sin(A)
    // Derivadas
    dxdt(1) = dAdt
    dxdt(2) = dWdt
endfunction

// Constantes
b = 1; g = 9.8; L = 1;
 
// Estado estacionario
Aee = 0; // %pi
Wee = 0;
xee = [Aee;Wee]
dxdtee = f(0,xee)

// Linealización
// dxdt = f(x) => dxddt = J*xd
J = numderivative(f,xee)

// Estabilidad
lambda = spec(J)
Estable = and(real(lambda) < 0)

// Condiciones iniciales
Aini = %pi/4; Wini = 0; 
//Aini = 0; Wini = 8.377820946; 
xini = [Aini;Wini]; 

// Tiempo
tfin = 10; dt = 0.1; t = 0:dt:tfin; 

// RESOLVER
x = ode(xini,0,t,f); 
A = x(1,:); W = x(2,:); 
X = L*sin(A); Y = -L*cos(A);

// Gráficas
scf(1); clf(1); 
plot(t,A);
a1 = gca; 
a1.x_location = 'origin'; a1.y_location = 'origin'; 
a1.box = 'off';
xgrid; xtitle('','t','A');

scf(2); 

for i = 1:length(t)

  drawlater();

    scf(1); plot(t(i),A(i),'.')

    clf(2);
    a2 = gca; 
    a2.x_location = 'origin'; 
    a2.y_location = 'origin'; 
    a2.data_bounds = [-1.5,-1.5; 1.5,1.5];
    a2.box = 'off'; 
    a2.isoview = 'on';
    a2.auto_ticks = 'off';
    plot(X(i),Y(i),'.');
    plot([0 X(i)],[0 Y(i)]);
    xstring(1,1,"t = " + string(int(t(i))));
  
  drawnow();

end 

