clear; clc;
// RDMP-3b.sce
// A => B
// No adiabático: camisa a temperatura variable

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = f(t,x)
    // Variables diferenciales
    CA = x(1)
    T  = x(2)
    TJ = x(3)
    // Ecuación de Arrhenius
    k  = k0*exp(-E/(R*T))
    // Velocidad de reacción
    r  = k*CA
    // Calor transferido del reactor a la camisa
    Q  = U*A*(T-TJ)
    // Balance de materia para A
    // d(V*CA)dt = -r*V
    dCAdt = -r  
    // Balance de energía en el reactor
    // d(V*RHO*CP*T)dt = -H*r*V - Q
    dTdt  = -H*r/(RHO*CP)  - Q/(V*RHO*CP)
    // Balance de energía en la camisa
    // d(VJ*RHOJ*CPJ*TJ)dt =  FJ*RHOJ*CPJ*(TJ0-TJ) + Q
    dTJdt = FJ*(TJ0-TJ)/VJ + Q/(VJ*RHOJ*CPJ)  
    // Derivadas
    dxdt(1) = dCAdt
    dxdt(2) = dTdt
    dxdt(3) = dTJdt
endfunction

// CONSTANTES
V = 1; // m3
RHO = 980; // kg/m3
CP = 4200; // J/(kg*K)
U = 400; // J/(m2*s*K)
A = 4; // m2
VJ = 0.1; // m3
FJ = 1E-3; //m3/s
TJ0 = 283 // // K
RHOJ = 1000; // kg/m3
CPJ = 4180; //J/(kg*K)
H = -5E5; // J/mol
k0 = 2.2E4; // s-1
E = 41570; // J/mol
R = 8.314; // J/(mol*K)

// CONDICIONES INICIALES
CAini = 500; // mol/m3
Tini = 283; // K
TJini = 283; // K
xini = [CAini; Tini; TJini];

// TIEMPO
tfin = 1500; dt = 1; t = 0:dt:tfin; // s

// RESOLVER
x = ode(xini,0,t,f);
CA = x(1,:); CAfin = CA($)
T = x(2,:); Tfin = T($)
TJ = x(3,:); TJfin = TJ($)

[Tmax,indexTmax] = max(T)
tTmax = t(indexTmax)

// GRÁFICAS
scf(1); clf(1);
plot(t,CA);
xgrid; xtitle('RDMP-3b','t','CA');

scf(2); clf(2);
plot(t,T,tTmax,Tmax,'ro',t,TJ);
xgrid; xtitle('RDMP-3b','t','T(azul), TJ(verde)');

scf(3); 
plot(FJ,Tmax,'ro');
xgrid; xtitle('RDMP-3b','FJ','Tmax');
