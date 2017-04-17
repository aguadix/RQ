clear; clc;
// RCMP-MULT-2a
// 1) A => B
// 2) B => C
// 3) B => D
// No adiabático
// Estado estacionario

V = 100; // V
F = 5; // L/min
CA0 = 1; CB0 = 0; CC0 = 0; CD0 = 0; // mol/L
T0 = 300; TC = 350;// K
CP = 1; // cal/(g*K)
RHO = 1000; // g/L
UA = 700; // cal/(min*K)

CAeeguess = 1; CBeeguess = 0; CCeeguess = 0; CDeeguess = 0; // mol/L 
Teeguess = 300; // K

xeeguess = [CAeeguess; CBeeguess; CCeeguess; CDeeguess; Teeguess];

function dxdt = f(x)
    k1 = exp(-2600/x(5) + 6); // min-1
    k2 = exp(-2200/x(5) + 7); // min-1
    k3 = exp(-6200/x(5) + 17); // min-1

    r1 = k1*x(1)
    r2 = k2*x(2)
    r3 = k3*x(2)

    dxdt(1) = F*(CA0-x(1))/V - r1
    dxdt(2) = F*(CB0-x(2))/V + r1 - r2 -r3
    dxdt(3) = F*(CC0-x(3))/V + r2
    dxdt(4) = F*(CD0-x(4))/V + r3
    dxdt(5) = F*(T0-x(5))/V + UA*(TC-x(5))/(RHO*V*CP)
endfunction

[xee,v,info] = fsolve(xeeguess,f)
CAee = xee(1)
CBee = xee(2)
CCee = xee(3)
CDee = xee(4)
Tee = xee(5)

scf(1);
plot(T0,CCee,'ro');
xgrid; xtitle('RCMP-MULT-2a','T0','CCee')
