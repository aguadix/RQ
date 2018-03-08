clear; clc;
// RCMP-2b
// A + B <=> P
// Isotermo
// Dinámica

F = 10; // L/min
CA0 = 1; CB0 = 1.5; CP0 = 0; // mol/L
V = 150; // L
kd = 0.1; // L/(mol*min)
Keq = 10; // L/mol

CAini = 0; CBini = 0; CPini = 0; // mol/L
xini = [CAini; CBini; CPini];

tfin = 200; dt = 0.5; // min
t = 0:dt:tfin;

function dxdt = f(t,x)
    r = kd*(x(1)*x(2) - x(3)/Keq)
    dxdt(1) = F*(CA0-x(1))/V - r
    dxdt(2) = F*(CB0-x(2))/V - r
    dxdt(3) = F*(CP0-x(3))/V + r
endfunction
 
x = ode(xini,0,t,f);
CA = x(1,:); CAee = CA($)
CB = x(2,:); CBee = CB($) 
CP = x(3,:); CPee = CP($)
XA = 1-CA/CA0; XAee = XA($)

scf(1); clf(1);
plot(t,CA,t,CB,t,CP);
xgrid; xtitle('RCMP-2b', 't', 'CA(azul), CB(verde), CP(rojo)');