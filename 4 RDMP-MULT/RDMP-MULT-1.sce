clear; clc;
// RDMP-MULT-1.sce
// 1) A => B
// 2) B => C
// 3) C => B
// 4) B => D
// Isotermo

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = f(t,x)
    // Variables diferenciales
    CA = x(1)
    CB = x(2)
    CC = x(3)
    CD = x(4)
    // Velocidades de reacción
    r1 = k1*CA
    r2 = k2*CB
    r3 = k3*CC
    r4 = k4*CB
    // Balance de materia para A
    // d(V*CA)dt = -r1*V
    dCAdt = -r1
    // Balance de materia para B
    // d(V*CB)dt = (r1-r2+r3-r4)*V
    dCBdt = r1-r2+r3-r4
    // Balance de materia para C
    // d(V*CC)dt = (r2-r3)*V
    dCCdt = r2-r3
    // Balance de materia para D
    // d(V*CD)dt = r4*V
    dCDdt = r4
    // Derivadas
    dxdt(1) = dCAdt
    dxdt(2) = dCBdt 
    dxdt(3) = dCCdt
    dxdt(4) = dCDdt
endfunction

// CONSTANTES
k1 = 0.01; k2 = 0.01; k3 = 0.05; k4 = 0.02; //min-1

// CONDICIONES INICIALES
CAini = 1; CBini = 0; CCini = 0; CDini = 0; // mol/L
xini = [CAini;CBini;CCini;CDini];

// TIEMPO
tfin = 500; dt = 0.1; t = 0:dt:tfin; //min

// RESOLVER
x = ode(xini,0,t,f);

CA = x(1,:); CAfin = CA($)
CB = x(2,:); CBfin = CB($)
CC = x(3,:); CCfin = CC($) 
CD = x(4,:); CDfin = CD($) 

// GRÁFICAS
scf(1); clf(1); 
plot(t,CA,t,CB,t,CC,t,CD);
xgrid; xtitle('RDMP-MULT-1','t','CA(azul), CB(verde), CC(rojo), CD(cian)');

indexA = find(CA > 0.5);
tA = dt*length(indexA)
plot(t(indexA),CA(indexA),'go');

indexB = find(CB > 0.15 & CB < 0.20);
tB = dt*length(indexB)
plot(t(indexB),CB(indexB),'go');

for i = 1:length(t)
    dxdt(:,i) = f(t(i),x(:,i));
end
dCCdt = dxdt(3,:);
indexC = find(dCCdt > 0);
tC = dt*length(indexC)
plot(t(indexC),CC(indexC),'go');

indexD = find(CD == max(CA,CB,CC,CD));
tD = dt*length(indexD)
plot(t(indexD),CD(indexD),'go');
