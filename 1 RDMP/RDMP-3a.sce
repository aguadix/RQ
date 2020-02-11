clear; clc;
// RDMP-3a.sce
// A => B
// No adiabático: camisa a temperatura constante

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = f(t,x)
    CA = x(1)
    T  = x(2)
    k = k0*exp(-E/(R*T))
    r = k*CA
    Q = U*A*(T-TJ)
    dCAdt = -r                             // Balance de materia para A
    dTdt = -H*r/(RHO*CP) -  Q/(V*RHO*CP)   // Balance de energía
    dxdt(1) = dCAdt
    dxdt(2) = dTdt
endfunction

// CONSTANTES
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

// CONDICIONES INICIALES
CAini = 500; // mol/m3
Tini = 283; // K
xini = [CAini; Tini];

// VECTOR DE TIEMPOS
tfin = 1500; dt = 1; t = 0:dt:tfin; // s

// RESOLVER
x = ode(xini,0,t,f);
CA = x(1,:); CAfin = CA($)
T = x(2,:); Tfin = T($)

[Tmax,indexTmax] = max(T)
tTmax = t(indexTmax)
CATmax = CA(indexTmax)

// GRÁFICAS
scf(1); clf(1); 
plot(t,CA,tTmax,CATmax,'ro');
xgrid; xtitle('RDMP-3a','t','CA');

scf(2); clf(2); 
plot(t,T,tTmax,Tmax,'ro');
xgrid; xtitle('RDMP-3a','t','T');
