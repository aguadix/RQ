clear; clc; 
// RCMP-1.sce
// A => B
// Isotermo

// (a) Estado estacionario

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

// (b) Dinámica

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = g(t,x)
    dxdt = f(x)
endfunction

// CONDICIONES INICIALES
CAini = 1; CBini = 0; // mol/L
xini = [CAini;CBini];

// TIEMPO
tfin = 20; dt = 0.1; t = 0:dt:tfin; // h

// RESOLVER
x = ode(xini,0,t,g);
CA = x(1,:); CAfin = CA($)
CB = x(2,:); CBfin = CB($)

// GRÁFICAS
scf(1); clf(1);
plot(t,CA,t,CB);
xgrid; xlabel('t'); legend('CA','CB',-2,%f);
