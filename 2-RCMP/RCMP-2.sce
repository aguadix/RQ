clear; clc; 
// RCMP-2.sce
// A + B <=> C
// Isotermo

// (a) Estado estacionario

// SISTEMA DE ECUACIONES ALGEBRAICAS
function dxdt = f(x)
    // Variables
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

// SOLUCIÓN SUPUESTA
CAeeguess = 1; CBeeguess = 1.5; CCeeguess = 0; // mol/L
xeeguess = [CAeeguess; CBeeguess; CCeeguess];

// RESOLVER
[xee,fxee,info] = fsolve(xeeguess,f)
CAee = xee(1)
CBee = xee(2)
CPee = xee(3)

// (b) Dinámica

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = g(t,x)
    dxdt = f(x)
endfunction

// CONDICIONES INICIALES
CAini = 0; CBini = 0; CCini = 0; // mol/L
xini = [CAini; CBini; CCini];

// TIEMPO
tfin = 150; dt = 0.5; t = 0:dt:tfin; // min

// RESOLVER
x = ode(xini,0,t,g);
CA = x(1,:); CAfin = CA($)
CB = x(2,:); CBfin = CB($) 
CC = x(3,:); CCfin = CC($)

dCAdt = diff(CA)/dt; dCBdt = diff(CB)/dt; dCCdt = diff(CC)/dt;
dCAdtee = 1E-5; dCBdtee = 1E-5; dCCdtee = 1E-5;// mol/(L*h)
indexCAee = find(abs(dCAdt)<dCAdtee,1); indexCBee = find(abs(dCBdt)<dCBdtee,1); indexCCee = find(abs(dCCdt)<dCCdtee,1);
tCAee = t(indexCAee), tCBee = t(indexCBee), tCCee = t(indexCCee)
CAee = CA(indexCAee), CBee = CB(indexCBee), CCee = CC(indexCCee)

// GRÁFICAS

scf(1); clf(1);
plot(t,CA,t,CB,t,CC);
plot(tCAee,CAee,'b.',tCBee,CBee,'g.', tCCee,CCee,'r.');
xgrid; xlabel('t'); legend('CA','CB','CC',-2,%f);

scf(2); clf(2); 
plot(t(1:$-1),abs(dCAdt),t(1:$-1),abs(dCBdt),t(1:$-1),abs(dCCdt));
plot(tCAee,dCAdtee,'b.',tCBee,dCBdtee,'g.',tCCee,dCCdtee,'r.'); 
xgrid; xlabel('t'); legend('|dCAdt|','|dCBdt|','|dCCdt|',-2,%f);
a2 = gca; a2.log_flags = "nl";
