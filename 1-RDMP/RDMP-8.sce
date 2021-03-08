clear; clc;
// RDMP-8.sce
// A(g) + B(g) <=> C(g)
// Isotermo, isobárico

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = f(t,x)
    // Variables diferenciales
    NA = x(1)
    NB = x(2)
    NC = x(3)
    // Moles totales
    N = NA + NB + NC + NI
    // Gas ideal
    V = N*R*T/P
    // Concentraciones
    CA = NA/V
    CB = NB/V
    CC = NC/V
    // Velocidad de reacción
    // r = rd - ri = kd*CA*CB - ki*CC = kd*CA*CB - kd*CC/Keq
    r = k*(CA*CB-CC/Keq)    
    // Balance de materia para A
    dNAdt = -r*V
    // Balance de materia para B
    dNBdt = -r*V
    // Balance de materia para C
    dNCdt =  r*V
    // Derivadas
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
xfin = x(:,$)
dxdtfin = f(tfin,xfin)
Equilibrio = abs(dxdtfin ./ xfin) < 1E-5


NA = x(1,:); NAeq = NA($)
NB = x(2,:); NBeq = NB($)
NC = x(3,:); NCeq = NC($)
XA = 1 - NA/NAini; XAeq = XA($)

N = NA + NB + NC + NI; Neq = N($)
V = N*R*T/P; Veq = V($)
CA = NA ./ V; CAeq = CA($) 
CB = NB ./ V; CBeq = CB($) 
CC = NC ./ V; CCeq = CC($) 

// GRÁFICAS
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
xgrid; xtitle('RDMP-8','NI','XAeq');
