clear; clc;
// RCMP-2b.sce
// A + B <=> C
// Isotermo
// Dinámica

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = f(t,x)
    // Variables diferenciales
    CA = x(1)
    CB = x(2)
    CC = x(3)
    // Velocidad de reacción
    // r = rd - ri = kd*CA*CB - ki*CC = kd*CA*CB - kd*CC/Keq
    r = kd*(CA*CB - CC/Keq)
    // Balance de materia para A
    // d(V*CA)dt = F*CA0 - F*CA - r*V
    dCAdt = F*(CA0-CA)/V - r
    // Balance de materia para B
    // d(V*CB)dt = F*CB0 - F*CB - r*V
    dCBdt = F*(CB0-CB)/V - r
    // Balance de materia para C
    // d(V*CC)dt = F*CC0 - F*CC + r*V
    dCCdt = F*(CC0-CC)/V + r
    // Derivadas
    dxdt(1) = dCAdt
    dxdt(2) = dCBdt
    dxdt(3) = dCCdt
endfunction

// CONSTANTES
F = 10; // L/min
CA0 = 1; CB0 = 1.5; CC0 = 0; // mol/L
V = 150; // L
kd = 0.1; // L/(mol*min)
Keq = 10; // L/mol

// CONDICIONES INICIALES
CAini = 0; CBini = 0; CCini = 0; // mol/L
xini = [CAini; CBini; CCini];

// TIEMPO
tfin = 150; dt = 0.5; t = 0:dt:tfin; // min

// RESOLVER
x = ode(xini,0,t,f);
xfin = x(:,$)
dxdtfin = f(tfin,xfin)
Estacionario = abs(dxdtfin ./ xfin) < 1E-5

CA = x(1,:); CAee = CA($)
CB = x(2,:); CBee = CB($) 
CC = x(3,:); CCee = CC($)

// GRÁFICAS
scf(1); clf(1);
plot(t,CA,t,CB,t,CC);
xgrid; xtitle('RCMP-2b', 't', 'CA(azul), CB(verde), CC(rojo)');
