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
Estable = real(lambda) < 0

// PLANO DE FASES
scf(1);
x1min = -10; x1max = 10; x1interval = x1min:x1max;
x2min = -10; x2max = 10; x2interval = x2min:x2max;
fchamp(f, 0, x1interval, x2interval);
g1 = gca;
g1.x_location = 'origin';
g1.y_location = 'origin';
g1.isoview    = 'on';
g1.data_bounds = [x1min,x2min ; x1max,x2max];

tfin = 10; dt = 0.1; t = 0:dt:tfin;
//xini = -10*v1 + 0*v2
 xini = [0.00001;0.00001];
// xini = locate(1)
x = ode(xini,0,t,f);
xfin = x(:,$)

plot(x(1,:),x(2,:),'o-');
plot(xini(1),xini(2),'go');
plot(xfin(1),xfin(2),'ro');
g1.data_bounds = [x1min,x2min ; x1max,x2max];
