clear; clc;
// SEMI-2.sce
// A + B => C
// Adiabático
// Dinámica

FB = 50; // L/h
CB0 = 1; // mol/L
T0 = 280; // K
RHO = 1000; // g/L
CP = 1; // cal/(g*K)
H = -8E4; // cal/mol

NAini = 500; NBini = 0; NCini = 0; // mol
Vini = 500; // L
Tini = 350; // K
xini = [NAini; NBini; NCini; Vini; Vini*Tini];

tfin = 20; dt = 0.01; // h
t = 0:dt:tfin;

function dxdt = f(t,x)
    if t < tfin/2 then F = FB;
       else F = 0;
    end

    CA = x(1)/x(4)
    CB = x(2)/x(4)
    CC = x(3)/x(4)
    T = x(5)/x(4)

    k = 1E7*exp(-5000/T); // L/(mol*h)
    r = k*CA*CB
    
    dxdt(1) = -r*x(4)
    dxdt(2) = F*CB0 - r*x(4)
    dxdt(3) = r*x(4)
    dxdt(4) = F
    dxdt(5) = F*T0 - r*x(4)*H/(RHO*CP)
endfunction

x = ode(xini,0,t,f);
NA = x(1,:); NAfin = NA($)
NB = x(2,:); NBfin = NB($)
NC = x(3,:); NCfin = NC($)
V = x(4,:); Vfin = V($)
VT = x(5,:);
T = VT./V; Tfin = T($)

scf(1); clf(1);
plot(t,NA,t,NB,t,NC);
xgrid; xtitle('SEMI-2','t','NA(azul), NB(verde), NC(rojo)');

scf(2); clf(2);
plot(t,V);
xgrid; xtitle('SEMI-2','t','V');

scf(3); clf(3);
plot(t,T);
xgrid; xtitle('SEMI-2','t','T');
