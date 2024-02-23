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
TXAobj = T(indexXAobj)

// GRÁFICAS
scf(1); clf(1); 
plot(t,CA);
xgrid; xlabel('t'); legend('CA',-2,%f);

scf(2); clf(2); 
plot(t,XA,'m-',tXAobj,XAobj,'mo');
xgrid; xlabel('t'); legend('XA',-2,%f);

scf(3); clf(3); 
plot(t,T,'r-',tXAobj,TXAobj,'ro');
xgrid; xlabel('t'); legend('T',-2,%f);
