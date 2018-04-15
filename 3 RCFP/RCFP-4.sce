clear; clc;
// RCFP-4.sce
// 4 A(g) => B(g) + 6 C(g)
// Isotermo, isobárico
// Estado estacionario

k = 10; // h-1
R = 8.314; // J/(mol*K)
T = 900; // K
P = 450E3; // Pa
D = 0.1; // m

NA0 = 40; NB0 = 0; NC0 = 0;// mol/h
x0 = [NA0; NB0; NC0];

Vtot = 0.75; dV = 0.001; // m3
V = 0:dV:Vtot;

function dxdV = f(V,x)
    N = x(1)+x(2)+x(3)
    F = N*R*T/P
    CA = x(1)/F
    CB = x(2)/F
    CC = x(3)/F
    r = k*CA    
    dxdV(1) = -r
    dxdV(2) = 1/4*r
    dxdV(3) = 6/4*r
endfunction

x = ode(x0,0,V,f);
NA = x(1,:); NB = x(2,:); NC = x(3,:);

XA = 1 - NA/NA0; XAs = XA($)
L = V/(%pi/4*D^2); // m 

XAobj = 0.8;
index = find(XA>XAobj,1);
Lobj = L(index)
NAobj = NA(index)
NBobj = NB(index)
NCobj = NC(index)

scf(1); clf(1); 
plot(L,XA,Lobj,XAobj,'ro');
xgrid; xtitle('RCFP-4','L','XA');

scf(2); clf(2); 
plot(L,NA,L,NB,L,NC,Lobj,NAobj,'ro',Lobj,NBobj,'ro',Lobj,NCobj,'ro');
xgrid; xtitle('RCFP-4','L','NA(azul), NB(verde), NC(rojo)');
