clear; clc;
// SEMI-1.sce
// 1) A + B => P
// 2) A + B => Q
// Isotermo
// Dinámica

k1 = 1; // L/(mol*min)
k2 = 2; // L^2/(mol^2*min)
VB = 1; // L
tB = 25; // min
FB = VB/tB; // L/min
CB0 = 1; // mol/L

NAini = 1; NBini = 0; NPini = 0; NQini = 0; // mol
Vini = 0.5; // L
xini = [NAini; NBini; NPini; NQini; Vini];

tfin = 50; dt = 0.01; // min
t = 0:dt:tfin;

function dxdt = f(t,x)
    if t < tB then F = FB;
       else F = 0;
    end

    CA = x(1)/x(5)
    CB = x(2)/x(5)
    CP = x(3)/x(5)
    CQ = x(4)/x(5)
    
    r1 = k1*CA*CB
    r2 = k2*CA*CB^2
    
    dxdt(1) = (-r1 - r2)*x(5)
    dxdt(2) = F*CB0 + (-r1 - r2)*x(5)
    dxdt(3) = r1*x(5)
    dxdt(4) = r2*x(5)
    dxdt(5) = F
endfunction

x = ode(xini,0,t,f);
NA = x(1,:); NAfin = NA($)
NB = x(2,:); NBfin = NB($)
NP = x(3,:); NPfin = NP($)
NQ = x(4,:); NQfin = NQ($)
V = x(5,:); Vfin = V($)

SEL = NPfin/NQfin

scf(1); clf(1);
plot(t,NA,t,NB,t,NP,t,NQ);
xgrid; xtitle('SEMI-1','t','NA(azul), NB(verde), NP(rojo), NQ(cian)');

scf(2); clf(2);
plot(t,V);
xgrid; xtitle('SEMI-1','t','V');

scf(3);
plot(tB,NPfin,'ro');
xgrid; xtitle('SEMI-1','tB','NPfin'); 

scf(4);
plot(tB,SEL,'ro');
xgrid; xtitle('SEMI-1','tB','SEL');