clear; clc;
// RDMP-8.sce
// A(g) + B(g) <=> C(g)
// Isotermo, isobárico

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = f(t,x)
    NA = x(1)
    NB = x(2)
    NC = x(3)
    N = NA + NB + NC + NI
    V = N*R*T/P
    CA = NA/V
    CB = NB/V
    CC = NC/V
    r = k*(CA*CB-CC/Keq)    
    dNAdt = -r*V    // Balance de materia para A
    dNBdt = -r*V    // Balance de materia para B
    dNCdt =  r*V    // Balance de materia para C
    dxdt(1) = dNAdt
    dxdt(2) = dNBdt
    dxdt(3) = dNCdt
endfunction

// CONSTANTES
k = 0.1; // m3/(mol*h)
Keq = 0.05; // m3/mol
R = 8.314; // J/(mol*K)
T = 500; // K
P = 1E6; // Pa
NI = 25; // mol

// CONDICIONES INICIALES
NAini = 50; NBini = 100; NCini = 0; // mol
xini = [NAini; NBini; NCini];

// TIEMPO
tfin = 1.5; dt = 0.001; t = 0:dt:tfin; // h

// RESOLVER
x = ode(xini,0,t,f);
f(tfin,x(:,$)) < 1E-5  // Equilibrio?
NA = x(1,:); NAeq = NA($)
NB = x(2,:); NBeq = NB($)
NC = x(3,:); NCeq = NC($)
XA = 1 - NA/NAini; XAeq = XA($)

N = NA+NB+NC+NI; Neq = N($)
V = N*R*T/P; Veq = V($)
CA = NA ./ V; CAeq = CA($) 
CB = NB ./ V; CBeq = CB($) 
CC = NC ./ V; CCeq = CC($) 

scf(1); clf(1); 
plot(t,V);
xgrid; xtitle('RDMP-8','t','V');

scf(2); clf(2); 
plot(t,NA,t,NB,t,NC);
xgrid; xtitle('RDMP-8','t','NA(azul), NB(verde), NC(rojo)');

scf(3); clf(3); 
plot(t,CA,t,CB,t,CC);
xgrid; xtitle('RDMP-8','t','CA(azul), CB(verde), CC(rojo)');

scf(4); 
plot(NI,XAeq,'ro');
xgrid; xtitle('RDMP-3b','NI','XAeq');
