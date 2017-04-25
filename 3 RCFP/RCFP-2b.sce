clear; clc;
// RCFP-2b
// A + B <=> P
// Adiabático
// Estado estacionario
// 2 etapas con enfriamiento intermedio

frac1 = 0.5;

H = -136400; // J/mol
RHO = 1150; // g/L
CP = 3.8; // J/(g*K)
kd0 = 1.75E8; // L/(mol*h)
E = 62350; // J/mol
Keq0 = 8.25E-22; // L/mol
R = 8.314; // J/(mol*K)
F = 50; // L/h 
D = 3; //dm

CA0 = 1.5; CB0 = 2; CP0 = 0.1; // mol/L
T0 = 310; // K

tautot = 120; dtau = 0.01; // h

function dxdtau = f(tau,x)
    kd = kd0*exp(-E/(R*x(4)))
    Keq = Keq0*exp(-H/(R*x(4)))
    r = kd*(x(1)*x(2) - x(3)/Keq)
    dxdtau(1) = -r
    dxdtau(2) = -r
    dxdtau(3) = r
    dxdtau(4) = -H*r/(RHO*CP)
endfunction

// RCFP-1

x01 = [CA0;CB0;CP0;T0];
tautot1 = tautot*frac1; 
tau1 = 0:dtau:tautot1;
V1 = tau1*F; // L
L1 = V1/(%pi/4*D^2); // dm 

x1 = ode(x01,0,tau1,f);
CA1 = x1(1,:); CA1s = CA1($)
CB1 = x1(2,:); CB1s = CB1($)
CP1 = x1(3,:); CP1s = CP1($)
T1 = x1(4,:); T1s = T1($)
XA1 = 1 - CA1/CA0; XA1s = XA1($)

// RCFP-2

x02 = [CA1s;CB1s;CP1s;T0];
tautot2 = tautot*(1-frac1); 
tau2 = 0:dtau:tautot2;
V2 = tau2*F; // L
L2 = V2/(%pi/4*D^2); // dm 

x2 = ode(x02,0,tau2,f);
CA2 = x2(1,:); CA2s = CA2($)
CB2 = x2(2,:); CB2s = CB2($)
CP2 = x2(3,:); CP2s = CP2($)
T2 = x2(4,:); T2s = T2($)
XA2 = 1 - CA2/CA0; XA2s = XA2($)

scf(1); clf(1); 
plot(L1,XA1,L2,XA2);
xgrid(); xtitle('RCFP-2b','L','XA');

scf(2); clf(2); 
plot(L1,T1,L2,T2);
xgrid(); xtitle('RCFP-2b','L','T');

scf(3); clf(3)  
plot(T1,XA1,T1s,XA1s,'ro',T2,XA2,T2s,XA2s,'ro');
xgrid; xtitle('RCFP-2b','T','XA');

scf(4);
plot(frac1, XA2s,'ro');
xgrid; xtitle('RCFP-2b','frac1','XA2s');
