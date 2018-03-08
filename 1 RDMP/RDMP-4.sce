clear; clc;
// RDMP-4.sce
// 2 A <=> P
// Isotermo

T = 420; // K
kd0 = 1.4E12; // L/(mol*h)
E = 105000; // J/mol
Keq0 = 6.9E8; // L/mol
H = 63000; // J/mol
R = 8.314; // J/(mol*K)

kd = kd0*exp(-E/(R*T)) // L/(mol*h)
Keq = Keq0*exp(-H/(R*T)) // L/mol

CAini = 8; CPini = 0; // mol/L
xini = [CAini; CPini];

tfin = 100; dt=0.1; // h
t = 0:dt:tfin;

function dxdt = f(t,x)
    r = kd*(x(1)^2 - x(2)/Keq)
    dxdt(1) = -r
    dxdt(2) = r/2
endfunction

x = ode(xini,0,t,f);
CA = x(1,:); CAeq = CA($)
CP = x(2,:); CPeq = CP($)

XA = 1 - CA/CAini; XAeq = XA($)
XAobj = 0.8;
index = find(XA>XAobj,1);
tobj = t(index)
CAobj = CA(index)
CPobj = CP(index)

scf(1);  
plot(T,XAeq,'ro');
xgrid; xtitle('RDMP-4','T','XAeq');

scf(2); clf(2); 
plot(t,CA,t,CP,tobj,CAobj,'ro',tobj,CPobj,'ro');
xgrid; xtitle('RDMP-4','t','CA(azul), CP(verde)');