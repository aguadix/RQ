clear; clc; 
// RDMP-2.sce
// A => B
// Adiabático

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = f(t,x)
    // Variables diferenciales
    CA = x(1)
    T  = x(2)
    // Ecuación de Arrhenius
    k = k0*exp(-E/(R*T))
    // Velocidad de reacción
    r = k*CA
    // Balance de materia para A
    // d(V*CA)dt = -r*V
    dCAdt = -r              
    // Balance de energía
    // d(V*RHO*CP*T)dt = -H*r*V
    dTdt  = -H*r/(RHO*CP)   
    // Derivadas
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

// TIEMPO
tfin = 1000; dt = 1; t = 0:dt:tfin;// s

// RESOLVER
x = ode(xini,0,t,f);
CA = x(1,:); CAfin = CA($)
T = x(2,:); Tfin = T($)

XA = 1 - CA/CAini; XAfin = XA($)
XAobj = 0.90;
indexXAobj = find(XA>XAobj,1);
tXAobj = t(indexXAobj)
CAXAobj = CA(indexXAobj)
TXAobj = T(indexXAobj)

// GRÁFICAS
scf(1); clf(1); 
plot(t,CA,tXAobj,CAXAobj,'ro');
xgrid; xtitle('RDMP-2','t','CA');

scf(2); clf(2); 
plot(t,T,tXAobj,TXAobj,'ro');
xgrid; xtitle('RDMP-2','t','T');
