clear; clc;
// RDMP-8
// A(g) + B(g) <=> P(g)
// Isotermo, isobárico

k = 0.1; // m3/(mol*h)
Keq = 0.05; // m3/mol
R = 8.314; // J/(mol*K)
T = 500; // K
P = 1E6; // Pa

NAini = 50; NBini = 100; NPini = 0; NI = 25; // mol
xini = [NAini; NBini; NPini];

tfin = 1; dt = 0.001; // h
t = 0:dt:tfin;

function dxdt = f(t,x)
    N = x(1) + x(2) + x(3) + NI
    V = N*R*T/P
    CA = x(1)/V
    CB = x(2)/V
    CP = x(3)/V
    r = k*(CA*CB-CP/Keq)    
    dxdt(1) = -r*V
    dxdt(2) = -r*V
    dxdt(3) = r*V
endfunction

x = ode(xini,0,t,f);
NA = x(1,:); NAeq = NA($)
NB = x(2,:); NBeq = NB($)
NP = x(3,:); NPeq = NP($)
XA = 1 - NA/NAini; XAeq = XA($)

N = NA+NB+NP+NI; Neq = N($)
V = N*R*T/P; Veq = V($)
CA = NA ./ V; CAeq = CA($) 
CB = NB ./ V; CBeq = CB($) 
CP = NP ./ V; CPeq = CP($) 

XAobj = 0.75;
index = find(XA>XAobj,1);
tobj = t(index)
Vobj = V(index)
CAobj = CA(index)
CBobj = CB(index)
CPobj = CP(index)

scf(1); clf(1); 
plot(t,V,tobj,Vobj,'ro');
xgrid; xtitle('RDMP-8','t','V');

scf(2); clf(2); 
plot(t,CA,t,CB,t,CP,tobj,CAobj,'ro',tobj,CBobj,'ro',tobj,CPobj,'ro');
xgrid; xtitle('RDMP-8','t','CA(azul), CB(verde), CP(rojo)');