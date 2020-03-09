clear; clc;
// RCMP-3b.sce
// A => B
// No adiabático
// Dinámica

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = f(t,x)
    // Variables
    CA = x(1)
    T  = x(2)
    // Ecuación de Arrhenius
    k = k0*exp(-E/(R*T))
    // Velocidad de reacción
    r = k*CA
    // Calor transferido del reactor a la camisa
    Q = UA*(T-TJ)
    // Balance de materia para A
    //d(V*CA)dt = F*CA0 - F*CA - r*V
    dCAdt = F*(CA0-CA)/V - r
    // Balance de energía
    // d(V*RHO*CP*T)dt = F*RHO*CP*T0 - F*RHO*CP*T -H*r*V - Q
    dTdt = F*(T0-T)/V - H*r/(RHO*CP) - Q/(V*RHO*CP) 
    // Derivadas
    dxdt(1) = dCAdt
    dxdt(2) = dTdt
endfunction

// CONSTANTES
CP = 0.8; // cal/(g*K)
RHO = 1000; // g/L
F = 20; // L/s
V = 1500; // L
UA = 10000; // cal/(K*s)
H = -80000; // cal/mol
T0 = 293; // K
TJ = 283; // K
CA0 = 2.5; // mol/L
k0 = 2.5E10; // 1/s
R = 1.987; // cal/(mol*K)
E = 21000; // cal/mol

// CONDICIONES INICIALES
CAini = 0; // mol/L
Tini = 280; // K
xini = [CAini; Tini];

// TIEMPO
tfin = 1000; dt = 1; t = 0:dt:tfin; // s

// RESOLVER
x = ode(xini,0,t,f);
Estacionario = f(tfin,x(:,$)) < 1E-5
CA = x(1,:); CAee = CA($)
T = x(2,:); Tee = T($)

// GRÁFICAS
scf(1);
plot(CA,T,'o');
xtitle('RCMP-3b','CA','T');

CAmin = 0; dCA = 0.2; CAmax = 3;
Tmin = 280; dT = 10; Tmax = 500;
fchamp(f,0,CAmin:dCA:CAmax,Tmin:dT:Tmax); // Campo vectorial
mtlb_axis([CAmin CAmax Tmin Tmax]);

scf(2); clf(2);
plot(t,CA);
xgrid; xtitle('RCMP-3b','t','CA');

scf(3); clf(3); 
plot(t,T);
xgrid; xtitle('RCMP-3b','t','T');
