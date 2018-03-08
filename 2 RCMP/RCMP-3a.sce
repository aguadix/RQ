clear; clc;
// RCMP-3a
// A => B
// Reactores en serie
// Isotermo
// Estado estacionario

N = 10;

F = 1; // L/h
CA0 = 1; // mol/L
V = 1; // L
k = 0.1; // 1/h

i = 1:N; CAeeguess(i) = 1; // mol/L
xeeguess = CAeeguess;

function dxdt = f(x)
        r(1) = k*x(1)
        dxdt(1) = F*(CA0-x(1))/V - r(1)
        i = 2:N
        r(i) = k*x(i)
        dxdt(i) = F*(x(i-1)-x(i))/V - r(i) 
endfunction

[xee,v,info] = fsolve(xeeguess,f)
CAee = xee
XAee = 1 - CAee/CA0