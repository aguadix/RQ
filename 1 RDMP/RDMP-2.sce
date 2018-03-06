clear; clc;
// RDMP-2
// A => B
// Adiabático

CP = 0.9; // cal/(g*K)
RHO = 1070; // g/L
H = -50400; // cal/mol
k0 = 4.15E5; // s-1
E = 11200; // cal/mol
R = 1.987; // cal/(mol*K)

CAini = 0.3; // mol/L
Tini = 288; // K
xini = [CAini; Tini];

tfin = 2000; dt = 1; // s
t = 0:dt:tfin;

function dxdt = f(t,x)
    k = k0*exp(-E/(R*x(2)))
    r = k*x(1)
    dxdt(1) = -r
    dxdt(2) = -H*r/(RHO*CP)
endfunction

x = ode(xini,0,t,f);
CA = x(1,:); CAfin = CA($)
T = x(2,:); Tfin = T($)

XA = 1 - CA/CAini;
XAobj = 0.95;
index = find(XA>XAobj,1);
tobj = t(index)
Tobj = T(index)

scf(1); clf(1); 
plot(t,XA,tobj,XAobj,'ro');
xgrid; xtitle('RDMP-2','t','XA');

scf(2); clf(2); 
plot(t,T,tobj,Tobj,'ro');
xgrid; xtitle('RDMP-2','t','T');