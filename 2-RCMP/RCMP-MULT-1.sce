clear; clc;
// RCMP-MULT-1a.sce
// 1) A + B => P*
// 2) P + B => Q
// 2 reactores isotermos en serie 

// (a) Estado estacionario

// SISTEMA DE ECUACIONES ALGEBRAICAS
function dxdt = f(x)
  // REACTOR 1
    // Variables
    CA1 = x(1)
    CB1 = x(2)
    CP1 = x(3)
    CQ1 = x(4)
    // Velocidades de reacción
    r11 = k1*CA1*CB1
    r21 = k2*CP1*CB1
    // Balances de materia
    // d(V1*CA1)dt = F*CA0 - F1*CA1 - r11*V1
    dCA1dt = (FA*CA0 - F1*CA1)/V1 - r11
    // d(V1*CB1)dt = FB1*CB0 - F1*CB1 - r11*V1 - r21*V1
    dCB1dt = (FB1*CB0 - F1*CB1)/V1 - r11 - r21
    // d(V1*CP1)dt = - F1*CP1 + r11*V1 - r21*V1
    dCP1dt = -F1*CP1/V1 + r11 -r21
    // d(V1*CQ1)dt = - F1*CQ1 + r21*V1
    dCQ1dt = -F1*CQ1/V1 + r21
    // Derivadas
    dxdt(1) = dCA1dt
    dxdt(2) = dCB1dt
    dxdt(3) = dCP1dt
    dxdt(4) = dCQ1dt
  // REACTOR 2
    // Variables
    CA2 = x(5)
    CB2 = x(6)
    CP2 = x(7)
    CQ2 = x(8)
    // Velocidades de reacción
    r12 = k1*CA2*CB2
    r22 = k2*CP2*CB2
    // Balances de materia
    // d(V2*CA2)dt = F1*CA1 - F2*CA2 - r12*V2
    dCA2dt = (F1*CA1 - F2*CA2)/V2 - r12
    // d(V2*CB2)dt = F1*CB1 + FB2*CB0- F2*CB2 - r12*V2 - r22*V2
    dCB2dt = (F1*CB1 + FB2*CB0 - F2*CB2)/V2 -r12 - r22
    // d(V2*CP2)dt = F1*CP1 - F2*CP2 + r12*V2 - r22*V2
    dCP2dt = (F1*CP1 - F2*CP2)/V2 + r12 -r22
    // d(V2*CQ2)dt = F1*CQ1 - F2*CQ2 + r22*V2
    dCQ2dt = (F1*CQ1 - F2*CQ2)/V2 + r22
    // Derivadas
    dxdt(5) = dCA2dt
    dxdt(6) = dCB2dt
    dxdt(7) = dCP2dt
    dxdt(8) = dCQ2dt
endfunction

// CONSTANTES
V1 = 1; V2 = 1; // L
FA = 0.003; FB = 0.003; // L/s
CA0 = 1; CB0 = 1; //mol/L
k1 = 1; k2 = 0.1; //L/(mol*s)
 
// SOLUCIÓN SUPUESTA
CA1eeguess = 1; CB1eeguess = 1; CP1eeguess = 0; CQ1eeguess = 0;
CA2eeguess = 1; CB2eeguess = 1; CP2eeguess = 0; CQ2eeguess = 0;  // mol/L
xeeguess = [CA1eeguess; CB1eeguess; CP1eeguess; CQ1eeguess; CA2eeguess; CB2eeguess; CP2eeguess; CQ2eeguess];

// OPTIMIZAR frac1 para MAXIMIZAR SEL
frac1interval = 0:0.01:1;

for i = 1:length(frac1interval)
    frac1 = frac1interval(i);
    FB1 = frac1*FB;
    FB2 = (1-frac1)*FB;
    F1 = FA + FB1;
    F2 = F1 + FB2;
    
    // RESOLVER
    xee = fsolve(xeeguess, f);
//    CA1ee = xee(1);
//    CB1ee = xee(2);
//    CP1ee = xee(3);
//    CQ1ee = xee(4);
//    CA2ee = xee(5);
//    CB2ee = xee(6);
    CP2ee = xee(7);
    CQ2ee = xee(8);
    SEL(i) = CP2ee/CQ2ee;
end

[SELmax,indexSELmax] = max(SEL)
frac1opt = frac1interval(indexSELmax)

// GRÁFICAS
scf(1); clf(1);
plot(frac1interval,SEL,'ro');
plot(frac1opt,SELmax,'x');
xgrid; xlabel('frac1'); ylabel('SEL');

// (b) Dinámica

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = g(t,x)
    dxdt = f(x)
endfunction

// CONSTANTES
FB1 = frac1opt*FB;
FB2 = (1-frac1opt)*FB;
F1 = FA + FB1;
F2 = F1 + FB2;

// CONDICIONES INICIALES
CA1ini = 0; CB1ini = 0; CP1ini = 0; CQ1ini = 0;
CA2ini = 0; CB2ini = 0; CP2ini = 0; CQ2ini = 0;  // mol/L
xini = [CA1ini; CB1ini; CP1ini; CQ1ini; CA2ini; CB2ini; CP2ini; CQ2ini];

// TIEMPO
tfin = 3000; dt = 1; t = 0:dt:tfin; // s

// RESOLVER
x = ode(xini,0,t,g);

// Reactor 1
CA1 = x(1,:); CA1fin = CA1($)
CB1 = x(2,:); CB1fin = CB1($)
CP1 = x(3,:); CP1fin = CP1($)
CQ1 = x(4,:); CQ1fin = CQ1($)
// Reactor 2
CA2 = x(5,:); CA2fin = CA2($)
CB2 = x(6,:); CB2fin = CB2($)
CP2 = x(7,:); CP2fin = CP2($)
CQ2 = x(8,:); CQ2fin = CQ2($)

SELfin = CP2fin/CQ2fin

// GRÁFICAS
scf(2); clf(2); // Reactor 1
plot(t,CA1,t,CB1,t,CP1,t,CQ1);
xgrid; xlabel('t'); legend('CA1','CB1','CP1','CQ1',-2,%f);

scf(3); clf(3); // Reactor 2
plot(t,CA2,t,CB2,t,CP2,t,CQ2);
xgrid; xlabel('t'); legend('CA2','CB2','CP2','CQ2',-2,%f);
