clear; clc;
// RDMP-1.sce
// A => B
// Isotermo

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = f(t,x)
    // Variables diferenciales
    CA = x(1)
    CB = x(2)
    // Velocidad de reacción
    r = k*CA
    // Balance de materia para A
    // d(V*CA)dt = -r*V
    dCAdt = -r
    // Balance de materia para B
    // d(V*CB)dt = r*V
    dCBdt =  r
    // Derivadas
    dxdt(1) = dCAdt
    dxdt(2) = dCBdt
endfunction

// CONSTANTES
k = 0.5; // h-1

// CONDICIONES INICIALES
CAini = 1; CBini = 0; // mol/L
xini = [CAini;CBini];

// TIEMPO
tfin = 5; dt = 0.01; t = 0:dt:tfin; // h

// RESOLVER
x = ode(xini,0,t,f);
CA = x(1,:); CAfin = CA($)
CB = x(2,:); CBfin = CB($)

XA = 1 - CA/CAini; XAfin = XA($)

// GRÁFICAS
scf(1); clf(1); 
plot(t,XA);
xgrid; xtitle('RDMP-1','t','XA');

scf(2); clf(2);
plot(t,CA,t,CB);
xgrid; xtitle('RDMP-1','t','CA(azul), CB(verde)');
