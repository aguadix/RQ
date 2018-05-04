clear; clc;
// RDMP-MULT-1
// 1) A => B
// 2) B => C
// 3) C => B
// 4) B => D
// Isotermo

k1 = 0.01; k2 = 0.01; k3 = 0.05; k4 = 0.02; //min-1

CAini = 1; CBini = 0; CCini = 0; CDini = 0; // mol/L
xini = [CAini;CBini;CCini;CDini];

tfin = 500; dt = 0.1; //min
t = 0:dt:tfin;

function dxdt = f(t,x)
    r1 = k1*x(1)
    r2 = k2*x(2)
    r3 = k3*x(3)
    r4 = k4*x(2)
    dxdt(1) = -r1
    dxdt(2) = r1-r2+r3-r4
    dxdt(3) = r2-r3
    dxdt(4) = r4
endfunction

x = ode(xini,0,t,f);

CA = x(1,:); CAfin = CA($)
[CAmax,indexCAmax] = max(CA)
tCAmax = t(indexCAmax) 

CB = x(2,:); CBfin = CB($)
[CBmax,indexCBmax] = max(CB)
tCBmax = t(indexCBmax) 

CC = x(3,:); CCfin = CC($) 
[CCmax,indexCCmax] = max(CC)
tCCmax = t(indexCCmax)

CD = x(4,:); CDfin = CD($) 
[CDmax,indexCDmax] = max(CD)
tCDmax = t(indexCDmax)

scf(1); clf(1); 
plot(t,CA,t,CB,t,CC,t,CD);
plot(tCAmax,CAmax,'ko',tCBmax,CBmax,'ko',tCCmax,CCmax,'ko',tCDmax,CDmax,'ko');
xgrid; xtitle('RDMP-MULT-1','t','CA(azul), CB(verde), CC(rojo), CD(cian)');