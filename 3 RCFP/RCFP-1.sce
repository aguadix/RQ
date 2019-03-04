clear; clc;
// RCFP-1.sce
// A + B <=> P
// Isotermo
// Estado estacionario

H = -136400; // J/mol
RHO = 1150; // g/L
CP = 3.8; // J/(g*K)
kd0 = 1.75E8; // L/(mol*h)
E = 62350; // J/mol
Keq0 = 8.25E-22; // L/mol
R = 8.314; // J/(mol*K)
F = 50; // L/h 
D = 3; // dm
T = 310; // K

CA0 = 1.5; CB0 = 2; CP0 = 0.1; // mol/L
x0 = [CA0;CB0;CP0];

tautot = 2000; dtau = 0.01; // h
tau = 0:dtau:tautot;

function dxdtau = f(tau,x)
    kd = kd0*exp(-E/(R*T))
    Keq = Keq0*exp(-H/(R*T))
    r = kd*(x(1)*x(2) - x(3)/Keq)
    dxdtau(1) = -r
    dxdtau(2) = -r
    dxdtau(3) = r
endfunction

x = ode(x0,0,tau,f);
CA = x(1,:); CB = x(2,:); CP = x(3,:);

XA = 1 - CA/CA0;
V = tau*F; // L
L = V/(%pi/4*D^2); // dm 

XAobj = 0.5;
index = find(XA>XAobj,1);
Lobj = L(index)

scf(1); clf(1); 
plot(L,XA,Lobj,XAobj,'ro');
xgrid; xtitle('RCFP-1','L','XA');