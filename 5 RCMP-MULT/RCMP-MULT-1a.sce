clear; clc;
// RCMP-MULT-1a.sce
// 1) A + B => P*
// 2) P + B => Q
// 2 reactores isotermos en serie 
// Estado estacionario

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
xgrid; xtitle('RCMP-MULT-1a','frac1','SEL');
