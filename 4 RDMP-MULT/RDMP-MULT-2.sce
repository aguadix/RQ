clear; clc;
// RDMP-MULT-2.sce
// 1) A => B
// 2) A => C
// 3) B => D
// No adiabático

V = 1; // m3
A = 5; // m2
U = 1000; // kcal/(h*m2*K)
RHO = 1000; // kg/m3
CP = 1; // kcal/(kg*K)
Tcold = 293; Thot = 353; // K 

CAini = 1; CBini = 0; CCini = 0; CDini = 0; // mol/L
Tini = 303; //K
xini = [CAini; CBini; CCini; CDini; Tini];

tfin = 2; dt = 0.01;//h
t = 0:dt:tfin;

function dxdt = f(t,x)
    if t < tfin/2 then TJ = TJ1;
        else TJ = TJ2;
    end
    k1 = exp(-1500/x(5) + 6); //h-1
    k2 = exp(-4000/x(5) + 12); //h-1
    k3 = exp(-3000/x(5) + 10); //h-1
    r1 = k1*x(1)
    r2 = k2*x(1)
    r3 = k3*x(2)
    dxdt(1) = -r1 - r2
    dxdt(2) = r1 - r3
    dxdt(3) = r2
    dxdt(4) = r3
    dxdt(5) = U*A*(TJ-x(5))/(V*RHO*CP)
endfunction

c = 1;
select c
    case 1 then TJ1 = Tcold; TJ2 = Tcold; // K
    case 2 then TJ1 = Thot;  TJ2 = Thot;  // K
    case 3 then TJ1 = Tcold; TJ2 = Thot;  // K
    case 4 then TJ1 = Thot;  TJ2 = Tcold; // K
end

x = ode(xini,0,t,f);
CA = x(1,:); CAfin = CA($)
CB = x(2,:); CBfin = CB($)
CC = x(3,:); CCfin = CC($)
CD = x(4,:); CDfin = CD($)
T  = x(5,:); Tfin = T($)

scf(1);clf(1);
plot(t,CA,t,CB,t,CC,t,CD);
xgrid; xtitle('RDMP-MULT-2','t','CA(azul),CB(verde),CC(rojo),CD(cian)');

scf(2);clf(2);
plot(t,T);
xgrid; xtitle('RDMP-MULT-2','t','T');

scf(3);
bar(c,[CAfin,CBfin,CCfin,CDfin],'stacked');
xgrid; xtitle('RDMP-MULT-2','c','CAfin(azul), CBfin(verde), CCfin(rojo), CDfin(cian)'); 
