clear; clc;
// RCMP-3b
// A => B
// Reactores en serie
// Isotermo
// Dinámica

N = 10;

F = 1; // L/h
CA0 = 1; // mol/L
V = 1; // L
k = 0.1; // 1/h

i = 1:N; CAini(i) = 0; // mol/L
xini = CAini;

tfin = 25; dt = 0.1; // h
t = 0:dt:tfin;

function dxdt = f(t,x)
        r(1) = k*x(1)
        dxdt(1) = F*(CA0-x(1))/V - r(1)
        i = 2:N
        r(i) = k*x(i)
        dxdt(i) = F*(x(i-1)-x(i))/V - r(i) 
endfunction

x = ode(xini,0,t,f);
CA = x; CAee = CA(:,$)
XA = 1 - CA/CA0; XAee = XA(:,$)
 
scf(1); clf(1);
plot(t,CA)
xgrid; xtitle('RCMP-3b', 't', 'CA');
