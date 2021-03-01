clear; clc; 
// INTRO-5.sce
// ESTABILIDAD DE UN SISTEMA LINEAL DE ECUACIONES DIFERENCIALES

function dxdt = f(t,x)
    // dxdt(1) = A(1,1)*x(1) + A(1,2)*x(2)
    // dxdt(2) = A(2,1)*x(1) + A(2,2)*x(2)
    dxdt = A*x
endfunction

 A = [-2.0   1.0; 1.0  -4.0]; // Nodo estable
// A = [ 5.0  -1.0; 3.0   1.0]; // Nodo inestable
// A = [ 2.0  -1.0; 3.0  -2.0]; // Silla inestable
// A = [ 1.0  -5.0; 1.0  -3.0]; // Espiral estable
// A = [ 2.0  -2.5; 1.8  -1.0]; // Espiral inestable
// A = [ 2.0  -5.0; 1.0  -2.0]; // Centro
 
// ESTADO ESTACIONARIO
// dxdt = A*x = 0 => xee = [0;0]

// PLANO DE FASES
scf(1);
x1min = -10; x1max = 10; x1interval = x1min:x1max;
x2min = -10; x2max = 10; x2interval = x2min:x2max;

// Líneas de pendiente nula
// dxdt(1) = A(1,1)*x(1) + A(1,2)*x(2) = 0
plot(x1interval,-A(1,1)*x1interval/A(1,2),'r-');
// dxdt(2) = A(2,1)*x(1) + A(2,2)*x(2) = 0
plot(x1interval,-A(2,1)*x1interval/A(2,2),'r--');

// Campo vectorial
fchamp(f, 0, x1interval, x2interval);
a1 = gca;
a1.x_location = 'origin';
a1.y_location = 'origin';
a1.isoview    = 'on';
a1.data_bounds = [x1min,x2min ; x1max,x2max];
a1.box = 'off';

// Trayectorias
tfin = 10; dt = 0.1; t = 0:dt:tfin;
xini = [0;0];
x = ode(xini,0,t,f);
x1 = x(1,:); x2 = x(2,:);
plot(x1,x2,'o-');
a1.data_bounds = [x1min,x2min ; x1max,x2max];

// CRITERIO DE ESTABILIDAD
// xini <> [0;0]; t = infinito; x = [0;0]

// SOLUCIÓN ANALÍTICA  
// x = v*exp(lambda*t)
// dxdt                   = A*x
// lambda*v*exp(lambda*t) = A*v*exp(lambda*t) 
// lambda*v               = A*v 
// lambda = valores propios
// v      = vectores propios 
lambda = spec(A)
Estable = and(real(lambda) < 0)
