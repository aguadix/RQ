clear; clc;
// RCFP-1c.sce
// A + B <=> C
// Adiabático
// Estado estacionario
// 2 etapas con enfriamiento intermedio

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdtau = f(tau,x)
    // Variables diferenciales
    CA = x(1)
    CB = x(2)
    CC = x(3)
    T  = x(4)
    // Ecuación de Arrhenius
    kd = kd0*exp(-E/(R*T))
    // Ecuación de Van't Hoff
    Keq = Keq0*exp(-H/(R*T))
    // Velocidad de reacción
    // r = rd - ri = kd*CA*CB - ki*CC = kd*CA*CB - kd*CC/Keq
    r = kd*(CA*CB - CC/Keq)
    // Balance de materia para A
    // RDMP: d(V*CA)dt = -r*V 
    dCAdtau = -r
    // Balance de materia para B
    // RDMP: d(V*Cb)dt = -r*V 
    dCBdtau = -r
    // Balance de materia para C
    // RDMP: d(V*Cc)dt = r*V 
    dCCdtau =  r
    // Balance de energía
    // RDMP: d(V*RHO*CP*T)dt = -H*r*V
    dTdtau = -H*r/(RHO*CP) 
    // Derivadas
    dxdtau(1) = dCAdtau
    dxdtau(2) = dCBdtau
    dxdtau(3) = dCCdtau
    dxdtau(4) = dTdtau
endfunction

// CONSTANTES
kd0 = 1.75E8; // L/(mol*h)
E = 62350; // J/mol
Keq0 = 8.25E-22; // L/mol
H = -136400; // J/mol
R = 8.314; // J/(mol*K)
RHO = 1150; // g/L
CP = 3.8; // J/(g*K)
F = 50; // L/h 
D = 3; // dm
L = 800; // dm
V = %pi/4*D^2*L // L
TAU = V/F // h

// RCFP-1
frac1 = 0.5;

// Entrada
CA0 = 1.5; CB0 = 2; CC0 = 0.1; // mol/L
T0 = 310; // K
x01 = [CA0;CB0;CC0;T0];

// Tiempo de residencia
TAU1 = frac1*TAU
L1 = frac1*L
tau1 = 0:TAU1/1000:TAU1; // h
l1 = 0:L1/1000:L1; // dm

// Resolver
x1 = ode(x01,0,tau1,f);
CA1 = x1(1,:); CA1s = CA1($)
CB1 = x1(2,:); CB1s = CB1($)
CC1 = x1(3,:); CC1s = CC1($)
T1  = x1(4,:); T1s  =  T1($)
XA1 = 1 - CA1/CA0; XA1s = XA1($)

// RCFP-2
frac2 = 1 - frac1

// Entrada
x02 = [CA1s;CB1s;CC1s;T0];

// Tiempo de residencia
TAU2 = frac2*TAU
L2 = frac2*L
tau2 = 0:TAU2/1000:TAU2; // h
l2 = 0:L2/1000:L2; // dm

// Resolver
x2 = ode(x02,0,tau2,f);
CA2 = x2(1,:); CA2s = CA2($)
CB2 = x2(2,:); CB2s = CB2($)
CC2 = x2(3,:); CCC2s = CC2($)
T2  = x2(4,:); T2s  =  T2($)
XA2 = 1 - CA2/CA0; XA2s = XA2($)

// GRÁFICAS

scf(1); clf(1); 
plot(l1,XA1,l2,XA2);
xgrid; xtitle('RCFP-2b','l','XA');

scf(2); clf(2); 
plot(l1,T1,l2,T2);
xgrid; xtitle('RCFP-1c','l','T');

scf(3); clf(3)  
plot(T1,XA1,T2,XA2);
xgrid; xtitle('RCFP-1c','T','XA');

scf(4);
plot(frac1, XA2s,'ro');
xgrid; xtitle('RCFP-1c','frac1','XA2s');
