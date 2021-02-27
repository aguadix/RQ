clear; clc;
// RCMP-MULT-2c.sce
// 1) 2 A => B
// 2)   A => C 
// No adiabático
// Dinámica
// https://youtu.be/uVSN_mFonxE

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = f(t,x)
    // Variables diferenciales
    CA = x(1)
    T  = x(2)
    // Ecuaciones de Arrhenius
    k1 = k01*exp(-E1/(R*T)) 
    k2 = k02*exp(-E2/(R*T)) 
    // Velocidades de reacción
    r1 = k1*CA^2
    r2 = k2*CA
    // Balance de materia para A
    // d(V*CA)dt = F*CA0 - F*CA - r1*V - r2*V
    dCAdt = F*(CA0-CA)/V - r1 - r2
    // Calor transferido del reactor a la camisa
    Q = UA*(T-TJ)
    // Balance de energía
    // d(V*RHO*CP*T)dt = F*RHO*CP*T0 - F*RHO*CP*T - H1*r1*V - H2*r2*V - Q
    dTdt = F*(T0-T)/V - (H1*r1 + H2*r2)/(RHO*CP) - Q/(V*RHO*CP)
    // Derivadas
    dxdt(1) = dCAdt
    dxdt(2) = dTdt
endfunction

// CONSTANTES
V   =  0.1; // L
F   =  0.01; // L/s 	
CA0 =  10; // mol/L  
T0  =  318; // K
TJ  =  318; // K
UA  =  371; // J/(s*K) 
CP  =  4.18; // J/(g*K)
RHO =  1000; // g/L
k01 =  1E16; // L/(s*mol)
E1  =  1.2E5; // J/mol 
H1  = -1.13E5; // J/mol
k02 =  9.5E12; // 1/s
E2  =  8.8E4; // J/mol 
H2  = -8.37E4; // J/mol
R   =  8.314; // J/(mol*K)

// CAMPO VECTORIAL
scf(1);
CAmin = 0;   dCA = 0.5; CAmax =  10;  // mol/L
Tmin  = 310; dT  = 2;    Tmax  = 350; // K 
fchamp(f,0,CAmin:dCA:CAmax,Tmin:dT:Tmax);

// CONDICIONES INICIALES
CAini = 0; // mol/L
Tini  = 310; // K
xini = [CAini;Tini];

// TIEMPO
tfin = 100; dt = 0.1; t = 0:dt:tfin; //s

// RESOLVER
x = ode(xini,0,t,f);
CA = x(1,:); CAee = CA($)
T  = x(2,:); Tee = T($)

// GRÁFICAS
scf(1);
plot(CA,T,'o-');
a1 = gca;
a1.data_bounds = [CAmin, Tmin ; CAmax,Tmax];

scf(2); clf(2);
subplot(2,1,1); plot(t,CA); xgrid; xtitle('CA');
subplot(2,1,2); plot(t,T) ; xgrid; xtitle('T');

