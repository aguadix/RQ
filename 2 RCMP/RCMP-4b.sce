clear; clc;
// RCMP-4b
// A => B
// No adiabático
// Estados estacionarios

CP = 0.8; // cal/(g*K)
RHO = 1000; // g/L
F = 20; // L/s
V = 1500; // L
UA = 10000; // cal/(K*s)
H = -80000; // cal/mol
T0 = 293; // K
TJ = 283; // K
CA0 = 2.5; // mol/L
k0 = 2.5E10; // 1/s
R = 1.987; // cal/(mol*K)
E = 21000; // cal/mol

CAeeguess = 2.5; // mol/L
Teeguess = 293; // K
xeeguess = [CAeeguess; Teeguess];

function dxdt = f(x)
    k = k0*exp(-E/(R*x(2)))
    r = k*x(1)
    Q = UA*(x(2)-TJ)
    dxdt(1) = F*(CA0-x(1))/V - r
    dxdt(2) = F*(T0-x(2))/V - H*r/(RHO*CP) - Q/(V*RHO*CP) 
endfunction

[xee,v,info] = fsolve(xeeguess,f)
CAee = xee(1)
Tee = xee(2)