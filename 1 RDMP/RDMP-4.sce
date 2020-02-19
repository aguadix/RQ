clear; clc;
// RDMP-4.sce
// 2 A <=> B
// Isotermo

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = f(t,x)
    CA = x(1)
    CB = x(2)
    r = kd*(CA^2 - CB/Keq)
    dCAdt = -r   // Balance de materia para A
    dCBdt = r/2  // Balance de materia para B
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
kd = kd0*exp(-E/(R*T)) // L/(mol*h)
Keq = Keq0*exp(-H/(R*T)) // L/mol

// CONDICIONES INICIALES
CAini = 5; CBini = 0; // mol/L
xini = [CAini; CBini];

// TIEMPO
tfin = 80; dt = 0.1; t = 0:dt:tfin; // h

// RESOLVER
x = ode(xini,0,t,f);
f(tfin,x(:,$)) < 1E-5  // Equilibrio?

CA = x(1,:); CAeq = CA($)
CB = x(2,:); CBeq = CB($)
XA = 1 - CA/CAini; XAeq = XA($)

indexCBCA = find(CB>CA,1);
tCBCA = t(indexCBCA)
CACBCA = CA(indexCBCA)

// GRÁFICAS
scf(1); clf(1); 
plot(t,CA,t,CB,tCBCA,CACBCA,'ro');
xgrid; xtitle('RDMP-4','t','CA(azul), CB(verde)');
