clear; clc;
// RCMP-4c
// A => B
// No adiabático
// Dinámica

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

CAini = 0; // mol/L
Tini = 280; // K
xini = [CAini; Tini];

tfin = 500; dt = 1; // s
t = 0:dt:tfin;

function dxdt = f(t,x)
    k = k0*exp(-E/(R*x(2)))
    r = k*x(1)
    dxdt(1) = F*(CA0-x(1))/V - r
    dxdt(2) = F*(T0-x(2))/V - H*r/(RHO*CP) - UA*(x(2)-TJ)/(V*RHO*CP) 
endfunction

x = ode(xini,0,t,f);
CA = x(1,:); CAee = CA($)
T = x(2,:); Tee = T($)

scf(1); 
plot(t,CA);
xgrid; xtitle('RCMP-4c','t','CA')

scf(2); 
plot(t,T);
xgrid; xtitle('RCMP-4c','t','T')

scf(3);
plot(T,CA,Tee,CAee,'ro');
xgrid; xtitle('RCMP-4c','T','CA')
