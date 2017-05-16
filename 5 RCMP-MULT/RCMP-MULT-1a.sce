clear; clc;
// RCMP-MULT-1a
// 1) A + B => P
// 2) P + B => Q
// 2 reactores isotermos en serie 
// https://files.acrobat.com/a/preview/f7245e03-48b9-4b4b-86a4-575f9a3b1937
// Estado estacionario

V1 = 1; V2 = 1; // L
CA0 = 1; CB0 = 1; //mol/L
k1 = 1; k2 = 0.1; //L/(mol*s)

F = 0.003; FBT = 0.003; // L/s
frac1 = 0.5;
FB1 = frac1*FBT;
FB2 = (1-frac1)*FBT;
F1 = F + FB1;
F2 = F1 + FB2;
    
CA1eeguess = 1; CB1eeguess = 1; CP1eeguess = 0; CQ1eeguess = 0;
CA2eeguess = 1; CB2eeguess = 1; CP2eeguess = 0; CQ2eeguess = 0;  // mol/L

xeeguess = [CA1eeguess; CB1eeguess; CP1eeguess; CQ1eeguess; CA2eeguess; CB2eeguess; CP2eeguess; CQ2eeguess];

function dxdt = f(x)
    r11 = k1*x(1)*x(2)
    r21 = k2*x(3)*x(2)
    dxdt(1) = (F*CA0 - F1*x(1))/V1 - r11
    dxdt(2) = (FB1*CB0 - F1*x(2))/V1 - r11 - r21
    dxdt(3) = -F1*x(3)/V1 + r11 -r21
    dxdt(4) = -F1*x(4)/V1 + r21

    r12 = k1*x(5)*x(6)
    r22 = k2*x(7)*x(6)
    dxdt(5) = (F1*x(1) - F2*x(5))/V2 - r12
    dxdt(6) = (F1*x(2) + FB2*CB0 - F2*x(6))/V2 -r12 - r22
    dxdt(7) = (F1*x(3) - F2*x(7))/V2 + r12 -r22
    dxdt(8) = (F1*x(4) - F2*x(8))/V2 + r22
endfunction

[xee,v,info] = fsolve(xeeguess, f)
CA1ee = xee(1)
CB1ee = xee(2)
CP1ee = xee(3)
CQ1ee = xee(4)
CA2ee = xee(5)
CB2ee = xee(6)
CP2ee = xee(7)
CQ2ee = xee(8)

SEL = CP2ee/CQ2ee

scf(1);
plot(frac1,SEL,'ro');
xgrid; xtitle('RCMP-MULT-1a','frac1','SEL');
