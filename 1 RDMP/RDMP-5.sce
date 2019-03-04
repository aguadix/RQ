clear; clc;
// RDMP-5.sce
// A + B <=> P
// Adiabático

H = -136400; // J/mol
RHO = 1150; // g/L
CP = 3.8; // J/(g*K)
kd0 = 1.75E8; // L/(mol*h)
E = 62350; // J/mol
Keq0 = 8.25E-22; // L/mol
R = 8.314; // J/(mol*K)

CAini = 1; CBini = 2; CPini = 0; // mol/L
Tini = 300; // K
xini = [CAini; CBini; CPini; Tini];

tfin = 2000; dt= 0.1; // h
t = 0:dt:tfin;

function dxdt = f(t,x)
    kd = kd0*exp(-E/(R*x(4)))
    Keq = Keq0*exp(-H/(R*x(4)))
    r = kd*(x(1)*x(2) - x(3)/Keq)
    dxdt(1) = -r
    dxdt(2) = -r
    dxdt(3) = r
    dxdt(4) = -H*r/(RHO*CP)
endfunction

x = ode(xini,0,t,f);
CA = x(1,:); CAeq = CA($)
CB = x(2,:); CBeq = CB($)
CP = x(3,:); CPeq = CP($)
T = x(4,:); Teq = T($)

XA = 1 - CA/CAini; XAeq = XA($)
XAobj = 0.6;
index = find(XA>XAobj,1);
tobj = t(index)
CAobj = CA(index)
CBobj = CB(index)
CPobj = CP(index)
Tobj = T(index)

scf(1);  
plot(Tini,XAeq,'ro');
xgrid; xtitle('RDMP-5','Tini','XAeq');

scf(2); clf(2); 
plot(t,CA,t,CB,t,CP,tobj,CAobj,'ro',tobj,CBobj,'ro',tobj,CPobj,'ro'); 
xgrid; xtitle('RDMP-5','t','CA(azul), CB(verde), CP(rojo)');

scf(3); clf(3); 
plot(t,T,tobj,Tobj,'ro');
xgrid; xtitle('RDMP-5','t','T');
