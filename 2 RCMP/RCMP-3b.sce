clear; clc;
// RCMP-3b.sce
// A => B
// No adiabático
// Estado estacionario

// SISTEMA DE ECUACIONES ALGEBRAICAS
function dxdt = f(x)
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

// SOLUCIÓN SUPUESTA
CAeeguess = 2.5; // mol/L
Teeguess = 293; // K
xeeguess = [CAeeguess; Teeguess];

// RESOLVER
[xee,v,info] = fsolve(xeeguess,f)
CAee = xee(1)
Tee = xee(2)

// GRÁFICAS
plot(CAee,Tee,'rx');

// ESTABILIDAD DE LOS ESTADOS ESTACIONARIOS

// Sistema no lineal
// dxdt = f(x)
// dCAdt = f1(CA,T)
// dTdt  = f2(CA,T)

// Linealización alrededor del estado estacionario
//  f1(CAee,Tee) = 0
//  f2(CAee,Tee) = 0 

// Desarrollo en serie de Taylor
//  dCAdt = f1(CAee,Tee) + df1dCAee*(CA-CAee) + df1dTee*(T-Tee)
//  dTdt  = f2(CAee,Tee) + df2dCAee*(CA-CAee) + df2dTee*(T-Tee)

// Variables de desviación
// CAd = CA - CAee  => dCAddt = dCAdt
// Td  = T  - Tee   => dTddt  = dTdt

// Sistema lineal
// dCAddt = df1dCAee*CAd + df1dTee*Td
// dTddt  = df2dCAee*CAd + df2dTee*Td
// dxddt = A*xd

// Jacobiano
// A = [df1dCAee  df1dTee
//      df2dCAee  df2dTee] 

A = numderivative(f,xee)
lambda = spec(A)  
Estable = real(lambda) < 0
