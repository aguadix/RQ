clear; clc;
// RCMP-2a.sce
// A + B <=> P
// Isotermo
// Estado estacionario

F = 10; // L/min
CA0 = 1; CB0 = 1.5; CP0 = 0; // mol/L
V = 150; // L
kd = 0.1; // L/(mol*min)
Keq = 10; // L/mol

CAeeguess = 1; CBeeguess = 1.5; CPeeguess = 0; // mol/L
xeeguess = [CAeeguess; CBeeguess; CPeeguess];

function dxdt = f(x)
    r = kd*(x(1)*x(2) - x(3)/Keq)
    dxdt(1) = F*(CA0-x(1))/V - r
    dxdt(2) = F*(CB0-x(2))/V - r
    dxdt(3) = F*(CP0-x(3))/V + r
endfunction

[xee,v,info] = fsolve(xeeguess,f)
CAee = xee(1)
CBee = xee(2)
CPee = xee(3)
XAee = 1-CAee/CA0