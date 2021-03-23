clear; clc;
// RCMP-1b.sce
// A => B
// Isotermo
// Dinámica

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = f(t,x)
    // Variables diferenciales
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

// CONDICIONES INICIALES
CAini = 1; CBini = 0; // mol/L
xini = [CAini;CBini];

// TIEMPO
tfin = 20; dt = 0.1; t = 0:dt:tfin; // h

// RESOLVER
x = ode(xini,0,t,f);
xfin = x(:,$)
dxdtfin = f(tfin,xfin)
Estacionario = abs(dxdtfin ./ xfin) < 1E-5
    
CA = x(1,:); CAee = CA($)
CB = x(2,:); CBee = CB($)

// GRÁFICAS
scf(1); clf(1);
plot(t,CA,t,CB);
xgrid; xtitle('RCMP-1b', 't', 'CA(azul), CB(verde)');
