clear; clc; 
// RCFP-1a.sce
// A + B <=> C
// Isotermo
// Estado estacionario

// EQUIVALENCIA
// RCFP                         RDMP             
// Estado estacionario          Dinámica         
// Tiempo de residencia         Tiempo           
// Entrada                      Valores iniciales        
// Salida                       Valores finales                   

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdtau = f(tau,x)
    // Variables diferenciales
    CA = x(1)
    CB = x(2)
    CC = x(3)
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
    // Derivadas
    dxdtau(1) = dCAdtau
    dxdtau(2) = dCBdtau
    dxdtau(3) = dCCdtau
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

T = 310; // K

// ENTRADA
CA0 = 1.5; CB0 = 2; CC0 = 0.1; // mol/L
x0 = [CA0;CB0;CC0];

// TIEMPO DE RESIDENCIA
tau = 0:TAU/100:TAU; // h
l = 0:L/100:L; // dm

// RESOLVER
x = ode(x0,0,tau,f);
CA = x(1,:); CAs = CA($)
CB = x(2,:); CBs = CB($) 
CC = x(3,:); CCs = CC($)
XA = 1 - CA/CA0; XAs = XA($)

// GRÁFICAS
scf(1); clf(1); 
plot(l,CA,l,CB,l,CC);
xgrid; xlabel('t'); legend('CA','CB','CC',-2,%f);

scf(2); clf(2); 
plot(l,XA,'m');
xgrid; xlabel('l'); legend('XA',-2,%f);
