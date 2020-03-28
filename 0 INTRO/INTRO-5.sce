clear; clc;
// INTRO-5.sce

// ESTABILIDAD DE UN SISTEMA LINEAL DE ECUACIONES DIFERENCIALES

function dxdt = f(t,x)
    // dxdt(1) = A(1,1)*x(1) + A(1,2)*x(2)
    // dxdt(2) = A(2,1)*x(1) + A(2,2)*x(2)
    dxdt = A*x
endfunction

// SOLUCCIÓN ANALÍTICA
// x = v*exp(lambda*t)

// DEMOSTRACIÓN
// dxdt                   = A*x
// lambda*v*exp(lambda*t) = A*v*exp(lambda*t) 
// lambda*v               = A*v 

// Donde:   lambda = valores propios de A
//          v      = vectores propios de A 

// EJEMPLO
 A = [-2   1 
       1  -4];    // Nodo estable
// A = [ 2  -1;
//       3  -2];  // Silla inestable

scf(1); 
fchamp(f, 0, [-10:10], [-10:10]);
a = gca();
a.x_location = "origin";
a.y_location = "origin";
a.isoview    = "on";
a.data_bounds = [-10,-10;10,10];

// Trayectoria
t = 0:0.01:10;
xini = locate(1)
x = ode(xini,0,t,f);
plot(x(1,:),x(2,:),'o');
a.data_bounds=[-10,-10;10,10];

// Estabilidad
lambda = spec(A)
Estable = real(lambda) < 0
