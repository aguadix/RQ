clear; clc;
// RCMP-MULT-2b.sce
// 1) A => B
// 2) B => C
// 3) B => D
// No adiabático
// Dinámica

V = 100; // V
F = 5; // L/min
CA0 = 1; CB0 = 0; CC0 = 0; CD0 = 0; // mol/L
T0 = 300; TC = 350;// K
CP = 1; // cal/(g*K)
RHO = 1000; // g/L
UA = 700; // cal/(min*K)

CAini = 0; CBini = 0; CCini = 0; CDini = 0; // mol/L 
Tini = 300; // K
xini = [CAini;CBini;CCini;CDini;Tini];

tfin = 250; dt = 0.01; // min
t = 0:dt:tfin;

function dxdt = f(t,x)
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
    dxdt(5) = F*(T0-x(5))/V + UA*(TC-x(5))/(RHO*CP*V)
endfunction

x = ode(xini,0,t,f);
CA = x(1,:); CAee = CA($)
CB = x(2,:); CBee = CB($)
CC = x(3,:); CCee = CC($)
CD = x(4,:); CDee = CD($)
T = x(5,:); Tee = T($)

scf(1); clf(1);
plot(t,CA,t,CB,t,CC,t,CD);
xgrid; xtitle('RCMP-MULT-2b', 't', 'CA(azul), CB(verde), CC(rojo), CD(cian)');

scf(2); clf(2);
plot(t,T);
xgrid; xtitle('RCMP-MULT-2b', 't', 'T');