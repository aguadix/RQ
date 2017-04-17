clear; clc;
// RCMP-1b
// A => B
// Isotermo
// Dinámica

F = 1; // L/h
CA0 = 1; // mol/L
V = 10; // L
k = 0.1; // 1/h

CAini = 1; // mol/L
xini = CAini;

tfin = 50; dt = 0.01; // h
t = 0:dt:tfin;

function dxdt = f(t,x)
     r = k*x
     dxdt = F*(CA0-x)/V - r
endfunction
 
x = ode(xini,0,t,f);
CA = x; CAee = CA($)
XA = 1 - CA/CA0; XAee = XA($)

scf(1); //clf(1);
plot(t,CA)
xgrid; xtitle('RCMP-1b', 't', 'CA');
