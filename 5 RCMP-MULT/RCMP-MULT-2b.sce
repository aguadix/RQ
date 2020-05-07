clear; clc;
// RCMP-MULT-2b.sce
// 1) 2 A => B
// 2)   A => C 
// No adiabático
// Estado estacionario
// https://youtu.be/...

// SISTEMA DE ECUACIONES ALGEBRAICAS
function dxdt = f(x)
    // Variables 
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
V   =  1.000E-01; // L
F   =  1.000E-02; // L/s 	
CA0 =  1.000E+01; // mol/L  
T0  =  3.180E+02; // K
TJ  =  3.180E+02; // K
UA  =  3.710E+02; // J/(s*K) 
CP  =  4.180E+00; // J/(g*K)
RHO =  1.000E+03; // g/L
k01 =  1.000E+16; // L/(s*mol)
E1  =  1.200E+05; // J/mol 
H1  = -1.130E+05; // J/mol
k02 =  9.500E+12; // 1/s
E2  =  8.800E+04; // J/mol 
H2  = -8.370E+04; // J/mol
R   =  8.314E+00; // J/(mol*K)

// SOLUCIÓN SUPUESTA
CAeeguess = 1.000E+01; // mol/L 
Teeguess = 3.180E+02; // K
xeeguess = [CAeeguess;Teeguess];

// RESOLVER
[xee,fxee,info] = fsolve(xeeguess,f)
CAee = xee(1)
Tee = xee(2)

// GRÁFICAS
scf(1);
plot(CAee,Tee,'x');

// LINEALIZACIÓN 
// Sistema no lineal   =>    Sistema lineal
// dxdt = f(x)         =>    dxddt  = A*xd
J = numderivative(f,xee); // Jacobiano

// ESTABILIDAD DE UN SISTEMA LINEAL DE ECUACIONES DIFERENCIALES
// Valores propios
lambda = spec(J)

// Critero de estabilidad
Estable = and(real(lambda) < 0)
