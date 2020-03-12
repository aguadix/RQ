clear; clc;
// RCMP-1a.sce
// A => B
// Isotermo
// Estado estacionario

// SISTEMA DE ECUACIONES ALGEBRAICAS
function dxdt = f(x)
    // Variables
    CA = x(1)
    CB = x(2)
    // Velocidad de reacción
    r = k*CA
    // Balance de materia para A
    // d(V*CA)dt = F*CA0 - F*CA - r*V
    dCAdt = F*(CA0-CA)/V - r
    // Balance de materia para B
    // d(V*CB)dt = F*CB0 - F*CB + r*V
    dCBdt = F*(CB0-CB)/V + r
    // Derivadas
    dxdt(1) = dCAdt
    dxdt(2) = dCBdt
endfunction

// CONSTANTES
F = 1; // L/h
CA0 = 1; CB0 = 0; // mol/L
V = 15; // L
k = 1; // 1/h

// SOLUCIÓN SUPUESTA
CAeeguess = 1; CBeeguess = 0; // mol/L
xeeguess = [CAeeguess;CBeeguess];

// RESOLVER
[xee,fxee,info] = fsolve(xeeguess,f)
CAee = xee(1)
CBee = xee(2)
