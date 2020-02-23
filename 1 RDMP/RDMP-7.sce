clear; clc;
// RDMP-7.sce
// A(g) => 2 B(g)
// Isotermo, isobárico

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = f(t,x)
    NA = x(1)
    NB  = x(2)
    N = NA + NB
    V = N*R*T/P
    CA = NA/V
    CB = NB/V
    r = k*CA    
    dNAdt = -r*V   // Balance de materia para A
    dNBdt = 2*r*V  // Balance de materia para B
    dxdt(1) = dNAdt
    dxdt(2) = dNBdt
endfunction

// CONSTANTES
k = 0.5; // h-1
R = 8.314; // J/(mol*K)
T = 400; // K
P = 8E5; // Pa

// CONDICIONES INICIALES
NAini = 10; NBini = 0; // mol
xini = [NAini; NBini];

// TIEMPO
tfin = 10; dt = 0.001; t = 0:dt:tfin; // h

// RESOLVER
x = ode(xini,0,t,f);
NA = x(1,:); NAfin = NA($)
NB = x(2,:); NBfin = NB($)

N = NA + NB; Nfin = N($)
V = N*R*T/P; Vfin = V($)
CA = NA ./ V; CAfin = CA($)
CB = NB ./ V; CBfin = CB($)

// GRÁFICAS
scf(1); clf(1); 
plot(t,V);
xgrid; xtitle('RDMP-7','t','V');

scf(2); clf(2); 
plot(t,NA,t,NB);
xgrid; xtitle('RDMP-7','t','NA(azul), NB(verde)');

scf(3); clf(3); 
plot(t,CA,t,CB);
xgrid; xtitle('RDMP-7','t','CA(azul), CB(verde)');
