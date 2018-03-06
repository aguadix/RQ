clear; clc;
// RDMP-3b
// A => B
// No adiabático: camisa a temperatura variable

V = 1; // m3
RHO = 980; // kg/m3
CP = 4200; // J/(kg*K)

U = 400; // J/(m2*s*K)
A = 4; // m2
VJ = 0.1; // m3
FJ = 1E-3; //m3/s
TJ0 = 283; // K
RHOJ = 1000; // kg/m3
CPJ = 4180; //J/(kg*K)

H = -5E5; // J/mol
k0 = 2.2E4; // s-1
E = 41570; // J/mol
R = 8.314; // J/(mol*K)

CAini = 500; // mol/m3
Tini = 283; // K
TJini = 283; // K
xini = [CAini; Tini; TJini];

tfin = 1400; dt = 1; // s
t = 0:dt:tfin;

function dxdt = f(t,x)
    k = k0*exp(-E/(R*x(2)))
    r = k*x(1)
    Q = U*A*(x(2)-x(3))
    dxdt(1) = -r
    dxdt(2) = -H*r/(RHO*CP) -  Q/(V*RHO*CP)
    dxdt(3) = FJ*(TJ0-x(3))/VJ + Q/(VJ*RHOJ*CPJ)
endfunction

x = ode(xini,0,t,f);
CA = x(1,:); CAfin = CA($)
T = x(2,:); Tfin = T($)
TJ = x(3,:); TJfin = TJ($)

scf(1); clf(1);
plot(t,CA);
xgrid; xtitle('RDMP-3b','t','CA');

scf(2); clf(2);
plot(t,T);
xgrid; xtitle('RDMP-3b','t','T');

scf(3); clf(3);
plot(t,TJ);
xgrid; xtitle('RDMP-3b','t','TJ');