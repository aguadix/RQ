clear; clc;
// RDMP-7
// A(g) => 2 P(g)
// Isotermo, isobárico

k = 0.5; // h-1
R = 8.314; // J/(mol*K)
T = 400; // K
P = 8E5; // Pa

NAini = 10; NPini = 0; // mol
xini = [NAini; NPini];

tfin = 10; dt = 0.001; // h
t = 0:dt:tfin;

function dxdt = f(t,x)
    N = x(1) + x(2)
    V = N*R*T/P
    CA = x(1)/V
    CP = x(2)/V
    r = k*CA    
    dxdt(1) = -r*V
    dxdt(2) = 2*r*V
endfunction

x = ode(xini,0,t,f);
NA = x(1,:); NAfin = NA($)
NP = x(2,:); NPfin = NP($)
XA = 1 - NA/NAini; XAfin = XA($)

N = NA + NP; Nfin = N($)
V = N*R*T/P; Vfin = V($)
CA = NA ./ V; CAfin = CA($)
CP = NP ./ V; CPfin = CP($)

XAobj = 0.5;
index = find(XA>XAobj,1);
tobj = t(index)
Vobj = V(index)
CAobj = CA(index)
CPobj = CP(index)

scf(1); clf(1); 
plot(t,V,tobj,Vobj,'ro');
xgrid; xtitle('RDMP-7','t','V')

scf(2); clf(2); 
plot(t,CA,t,CP,tobj,CAobj,'ro',tobj,CPobj,'ro');
xgrid; xtitle('RDMP-7','t','CA(azul), CP(verde)')
