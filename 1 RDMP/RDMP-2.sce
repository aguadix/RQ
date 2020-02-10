clear; clc;
// RDMP-2.sce
// A => B
// Adiabático

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = f(t,x)
    CA = x(1)
    T  = x(2)
    k = k0*exp(-E/(R*T))
    r = k*CA
    dCAdt = -r              // Balance de materia para A
    dTdt  = -H*r/(RHO*CP)   // Balance de energía
    dxdt(1) = dCAdt
    dxdt(2) = dTdt
endfunction

// CONSTANTES
CP = 0.9; // cal/(g*K)
RHO = 1070; // g/L
H = -50400; // cal/mol
k0 = 4.15E5; // s-1
E = 11200; // cal/mol
R = 1.987; // cal/(mol*K)

// CONDICIONES INICIALES
CAini = 0.5; // mol/L
Tini = 285; // K
xini = [CAini; Tini];

// VECTOR DE TIEMPOS
tfin = 2000; dt = 1; t = 0:dt:tfin;// s

// RESOLVER
x = ode(xini,0,t,f);
CA = x(1,:); CAfin = CA($)
T = x(2,:); Tfin = T($)

XA = 1 - CA/CAini;
XAobj = 0.90;
indexobj = find(XA>XAobj,1);
tobj = t(indexobj)
CAobj = CA(indexobj)
Tobj = T(indexobj)

// GRÁFICAS
scf(1); clf(1); 
plot(t,CA,tobj,CAobj,'ro');
xgrid; xtitle('RDMP-2','t','CA');

scf(2); clf(2); 
plot(t,T,tobj,Tobj,'ro');
xgrid; xtitle('RDMP-2','t','T');
