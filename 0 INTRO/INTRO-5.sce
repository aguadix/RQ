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
// A = [ 2.0  -1.0; 3.0  -2.0]; // Silla 
// A = [ 1.0  -5.0; 1.0  -3.0]; // Espiral estable
// A = [ 2.0  -2.5; 1.8  -1.0]; // Espiral inestable
// A = [ 2.0  -5.0; 1.0  -2.0]; // Centro
 
// SOLUCIÓN ANALÍTICA PARTICULAR 
// x = v*exp(lambda*t)

// DEMOSTRACIÓN
// dxdt                   = A*x
// lambda*v*exp(lambda*t) = A*v*exp(lambda*t) 
// lambda*v               = A*v 

// Donde:   lambda = valores propios (lambda1, lambda2)
//          v      = vectores propios (v1, v2) 

//lambda = spec(A)
[v,diaglambda] = spec(A)
lambda = diag(diaglambda)

lambda1 = lambda(1)
v1 = v(:,1)
A*v1
lambda1*v1 

lambda2 = lambda(2)
v2 = v(:,2)
A*v2
lambda2*v2

// SOLUCCIÓN ANALÍTICA GENERAL
// x = c1*v1*exp(lambda1*t) + c2*v2*exp(lambda2*t)  
// x1 = c1*v1(1)*exp(lambda1*t) + c2*v2(1)*exp(lambda2*t)
// x2 = c1*v1(2)*exp(lambda1*t) + c2*v2(2)*exp(lambda2*t)

// c1,c2 = Constantes dependientes de las condiciones iniciales

// CRITERIO DE ESTABILIDAD
// t => infinito
// x1 => 0, x2 => 0
// lambda1 < 0, lambda2 < 0
Estable = real(lambda) < 0

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

// Trayectoria
tfin = 10; dt = 0.1; t = 0:dt:tfin;
xini = 10*v1 + 0*v2
// xini = [10;10];
// xini = locate(1)
x = ode(xini,0,t,f);
plot(x(1,:),x(2,:),'o-');
a1.data_bounds = [x1min,x2min ; x1max,x2max];
