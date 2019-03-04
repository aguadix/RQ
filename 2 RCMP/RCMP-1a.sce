clear; clc;
// RCMP-1a.sce
// A => B
// Isotermo
// Estado estacionario

F = 1; // L/h
CA0 = 1; // mol/L
V = 10; // L
k = 0.1; // 1/h

CAeeguess = 1; // mol/L
xeeguess = CAeeguess;

function dxdt = f(x)
     r = k*x
     dxdt = F*(CA0-x)/V - r
endfunction

[xee,v,info] = fsolve(xeeguess,f)
CAee = xee
XAee = 1 - CAee/CA0
