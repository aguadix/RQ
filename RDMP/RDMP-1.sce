clear; clc;
// RDMP-01
// A => B
// Isotermo

k = 0.8; // h-1

CAini = 1; CBini = 0; // mol/L
xini = [CAini;CBini];

tfin = 5; dt = 0.01; // h
t = 0:dt:tfin;

function dxdt = f(t,x)
    r = k*x(1)
    dxdt(1) = -r
    dxdt(2) = r
endfunction

x = ode(xini,0,t,f);
CA = x(1,:); CAfin = CA($)
CB = x(2,:); CBfin = CB($)

XA = 1 - CA/CAini;
tp = 3; // h
Prod = CBfin/(tfin+tp) // mol/(L*h)

scf(1); clf(1); 
plot(t,XA);
xgrid; xtitle('RDMP-01','t','XA');

scf(2); 
plot(tfin,Prod,'ro');
xgrid; xtitle('RDMP-01','tfin','Prod');
