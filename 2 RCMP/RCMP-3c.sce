clear; clc;
// RCMP-3c.sce
// A => B
// No adiabático
// Dinámica
// https://youtu.be/2ao05FndqfA

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
UA = 1E4; // cal/(K*s)
H = -8E4; // cal/mol
T0 = 293; // K
TJ = 283; // K
CA0 = 2.5; // mol/L
k0 = 2.5E10; // 1/s
R = 1.987; // cal/(mol*K)
E = 2.1E4; // cal/mol

// CAMPO VECTORIAL
scf(1);
CAmin = 0; dCA = 0.1; CAmax = 3;
Tmin = 280; dT = 10; Tmax = 500;
fchamp(f,0,CAmin:dCA:CAmax,Tmin:dT:Tmax);
a1 = gca;
a1.data_bounds = [CAmin, Tmin ; CAmax,Tmax];

// CONDICIONES INICIALES
CAini = 0; // mol/L
Tini = 280; // K
xini = [CAini; Tini];

// TIEMPO
tfin = 1000; dt = 1; t = 0:dt:tfin; // s

// RESOLVER
x = ode(xini,0,t,f);
CA = x(1,:); CAee = CA($)
T = x(2,:); Tee = T($)

// TRAYECTORIA
scf(1);
plot(CA,T,'o-');
a1.data_bounds = [CAmin, Tmin ; CAmax,Tmax];
