clear; clc;
// RDMP-3a.sce
// A => B
// No adiabático: camisa a temperatura constante

V = 1; // m3
RHO = 980; // kg/m3
CP = 4200; // J/(kg*K)

U = 400; // J/(m2*s*K)
A = 4; // m2
TJ = 283; // K

H = -5E5; // J/mol
k0 = 2.2E4; // s-1
E = 41570; // J/mol
R = 8.314; // J/(mol*K)

CAini = 500; // mol/m3
Tini = 283; // K
xini = [CAini; Tini];

tfin = 1400; dt = 1; // s
t = 0:dt:tfin;

function dxdt = f(t,x)
    k = k0*exp(-E/(R*x(2)))
    r = k*x(1)
    Q = U*A*(x(2)-TJ)
    dxdt(1) = -r
    dxdt(2) = -H*r/(RHO*CP) -  Q/(V*RHO*CP)
endfunction

x = ode(xini,0,t,f);
CA = x(1,:); CAfin = CA($)
T = x(2,:); Tfin = T($)

[Tmax,index] = max(T)
tTmax = t(index)
CATmax = CA(index)

scf(1); clf(1); 
plot(t,CA,tTmax,CATmax,'ro');
xgrid; xtitle('RDMP-3a','t','CA');

scf(2); clf(2); 
plot(t,T,tTmax,Tmax,'ro');
xgrid; xtitle('RDMP-3a','t','T');
