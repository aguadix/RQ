clear; clc; 
// RDMP-4.sce
// 2 A <=> B
// Isotermo

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = f(t,x)
    // Variables diferenciales
    CA = x(1)
    CB = x(2)
    // Velocidad de reacción
    // r = rd - ri = kd*CA^2 - ki*CB = kd*CA^2 - kd*CB/Keq
    r = kd*(CA^2 - CB/Keq)
    // Balance de materia para A
    // d(V*CA)dt = -r*V
    dCAdt = -r 
    // Balance de materia para B
    // d(V*CB)dt = r/2*V
    dCBdt = r/2
    // Derivadas
    dxdt(1) = dCAdt
    dxdt(2) = dCBdt
endfunction

// CONSTANTES
T = 420; // K
kd0 = 1.4E12; // L/(mol*h)
E = 105000; // J/mol
Keq0 = 6.9E8; // L/mol
H = 63000; // J/mol
R = 8.314; // J/(mol*K)
kd = kd0*exp(-E/(R*T))   // Ecuación de Arrhenius
Keq = Keq0*exp(-H/(R*T)) // Ecuación de Van't Hoff

// CONDICIONES INICIALES
CAini = 5; CBini = 0; // mol/L
xini = [CAini; CBini];

// TIEMPO
tfin = 100; dt = 0.1; t = 0:dt:tfin; // h

// RESOLVER
x = ode(xini,0,t,f);
xfin = x(:,$)
dxdtfin = f(tfin,xfin)
Equilibrio = abs(dxdtfin ./ xfin) < 1E-5

CA = x(1,:); CAeq = CA($)
CB = x(2,:); CBeq = CB($)
XA = 1 - CA/CAini; XAeq = XA($)

indexCACB = find(CA<CB,1);
tCACB = t(indexCACB)
CACACB = CA(indexCACB)

// GRÁFICAS
scf(1); clf(1); 
plot(t,CA,t,CB,tCACB,CACACB,'ro');
xgrid; xtitle('RDMP-4','t','CA(azul), CB(verde)');
