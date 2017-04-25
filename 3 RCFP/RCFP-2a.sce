clear; clc;
// RCFP-2a
// A + B <=> P
// Adiabático
// Estado estacionario

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
x0 = [CA0;CB0;CP0;T0];

tautot = 100; dtau = 0.01; // h
tau = 0:dtau:tautot;

function dxdtau = f(tau,x)
    kd = kd0*exp(-E/(R*x(4)))
    Keq = Keq0*exp(-H/(R*x(4)))
    r = kd*(x(1)*x(2) - x(3)/Keq)
    dxdtau(1) = -r
    dxdtau(2) = -r
    dxdtau(3) = r
    dxdtau(4) = -H*r/(RHO*CP) 
endfunction

x = ode(x0,0,tau,f);
CA = x(1,:); CB = x(2,:); CP = x(3,:); T = x(4,:);

XA = 1 - CA/CA0;
V = tau*F; // L
L = V/(%pi/4*D^2); // dm 

XAobj = 0.5;
index = find(XA>XAobj,1);
Lobj = L(index)
Tobj = T(index)

scf(1); clf(1); 
plot(L,XA,Lobj,XAobj,'ro');
xgrid; xtitle('RCFP-2a','L','XA');

scf(2); clf(2); 
plot(L,T,Lobj,Tobj,'ro');
xgrid; xtitle('RCFP-2a','L','T');
