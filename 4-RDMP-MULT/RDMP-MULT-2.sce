clear; clc;
// RDMP-MULT-2.sce
// 1) A => B
// 2) A => C
// 3) B => D*
// No adiabático

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = f(t,x)
    // Variables diferenciales
    CA = x(1)
    CB = x(2)
    CC = x(3)
    CD = x(4)
    T  = x(5)
    // Ecuaciones de Arrhenius
    k1 = exp(-1500/T +  6); //h-1
    k2 = exp(-4000/T + 12); //h-1
    k3 = exp(-3000/T + 10); //h-1
    // Velocidades de reacción    
    r1 = k1*CA
    r2 = k2*CA
    r3 = k3*CB
    // Balance de materia para A
    // d(V*CA)dt = (-r1-r2)*V
    dCAdt = -r1 - r2
    // Balance de materia para B
    // d(V*CB)dt = (r1-r3)*V
    dCBdt =  r1 - r3
    // Balance de materia para C
    // d(V*CC)dt = r2*V
    dCCdt =  r2
    // Balance de materia para D
    // d(V*CD)dt = r3*V
    dCDdt =  r3
    // Temperatura de la camisa
    if t < tfin/2 then TJ = TJ1;
        else TJ = TJ2;
    end
    // Calor transferido del reactor a la camisa
    Q = U*A*(T-TJ)
    // Balance de energía 
    // d(V*RHO*CP*T) = - Q
    dTdt = - Q/(V*RHO*CP) 
    // Derivadas
    dxdt(1) = dCAdt
    dxdt(2) = dCBdt
    dxdt(3) = dCCdt
    dxdt(4) = dCDdt
    dxdt(5) = dTdt
endfunction

// CONSTANTES
V = 1; // m3
A = 5; // m2
U = 1000; // kcal/(h*m2*K)
RHO = 1000; // kg/m3
CP = 1; // kcal/(kg*K)
Tcold = 293; Thot = 353; // K 

// Operación de la camisa
op = 4;
select op
    case 1 then TJ1 = Tcold; TJ2 = Tcold; // K
    case 2 then TJ1 = Thot;  TJ2 = Thot;  // K
    case 3 then TJ1 = Tcold; TJ2 = Thot;  // K
    case 4 then TJ1 = Thot;  TJ2 = Tcold; // K
end

// CONDICIONES INICIALES
CAini = 1; CBini = 0; CCini = 0; CDini = 0; // mol/L
Tini = 303; //K
xini = [CAini; CBini; CCini; CDini; Tini];

// TIEMPO
tfin = 2; dt = 0.01; t = 0:dt:tfin; //h

// RESOLVER
x = ode(xini,0,t,f);
CA = x(1,:); CAfin = CA($)
CB = x(2,:); CBfin = CB($)
CC = x(3,:); CCfin = CC($)
CD = x(4,:); CDfin = CD($)
T  = x(5,:); Tfin = T($)

// GRÁFICAS
scf(1);clf(1);
plot(t,CA,t,CB,t,CC,t,CD);
xgrid; xtitle('RDMP-MULT-2','t','CA(azul),CB(verde),CC(rojo),CD(cian)');

scf(2);clf(2);
plot(t,T);
xgrid; xtitle('RDMP-MULT-2','t','T');

scf(3);
bar(op,[CAfin,CBfin,CCfin,CDfin],'stacked');
xgrid; xtitle('RDMP-MULT-2','op','CAfin(azul), CBfin(verde), CCfin(rojo), CDfin(cian)'); 
