clear; clc;
// RCMP-3b.sce
// A => B
// No adiabático
// Estado estacionario
// https://youtu.be/09rxFzRxyss

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
scf(1);
plot(CAee,Tee,'rx');

// LINEALIZACIÓN
// Sistema no lineal   =>    Sistema lineal
// dxdt = f(x)         =>    dxddt  = J*xd
J = numderivative(f,xee); // Jacobiano

// ESTABILIDAD
// Valores propios
lambda = spec(J)  

// Critero de estabilidad
Estable = and(real(lambda) < 0)

