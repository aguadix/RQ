clear; clc;
// RCMP-MULT-1b
// 1) A + B => P
// 2) P + B => Q
// 2 reactores isotermos en serie 
// https://goo.gl/t8nQVT
// Dinámica

V1 = 1; V2 = 1; // L
CA0 = 1; CB0 = 1; //mol/L
k1 = 1; k2 = 0.1; //L/(mol*s)

F = 0.003; FBT = 0.003; // L/s 
frac1 = 0.5;
FB1 = frac1*FBT; 
FB2 = (1-frac1)*FBT; 
F1 = F + FB1; 
F2 = F1 + FB2;

CA1ini = 0; CB1ini = 0; CP1ini = 0; CQ1ini = 0;
CA2ini = 0; CB2ini = 0; CP2ini = 0; CQ2ini = 0;  // mol/L
xini = [CA1ini; CB1ini; CP1ini; CQ1ini; CA2ini; CB2ini; CP2ini; CQ2ini];

tfin = 2500; dt = 1; // s
t = 0:dt:tfin;

function dxdt = f(t,x)
    r11 = k1*x(1)*x(2)
    r21 = k2*x(3)*x(2)
    dxdt(1) = (F*CA0 - F1*x(1))/V1 - r11
    dxdt(2) = (FB1*CB0 - F1*x(2))/V1 -r11 - r21
    dxdt(3) = -F1*x(3)/V1 + r11 -r21
    dxdt(4) = -F1*x(4)/V1 + r21

    r12 = k1*x(5)*x(6)
    r22 = k2*x(7)*x(6)
    dxdt(5) = (F1*x(1) - F2*x(5))/V2 - r12
    dxdt(6) = (F1*x(2) + FB2*CB0 - F2*x(6))/V2 -r12 - r22
    dxdt(7) = (F1*x(3) - F2*x(7))/V2 + r12 -r22
    dxdt(8) = (F1*x(4) - F2*x(8))/V2 + r22
endfunction

x = ode(xini,0,t,f);
CA1 = x(1,:); CA1ee = CA1($)
CB1 = x(2,:); CB1ee = CB1($)
CP1 = x(3,:); CP1ee = CP1($)
CQ1 = x(4,:); CQ1ee = CQ1($)
CA2 = x(5,:); CA2ee = CA2($)
CB2 = x(6,:); CB2ee = CB2($)
CP2 = x(7,:); CP2ee = CP2($)
CQ2 = x(8,:); CQ2ee = CQ2($)

SEL = CP2ee/CQ2ee

scf(1); clf(1);
plot(t,CA1,t,CB1,t,CP1,t,CQ1);
xgrid; xtitle('RCMP-MULT-1b','t','CA1(azul), CB1(verde), CP1(rojo), CQ1(cian)');

scf(2); clf(2);
plot(t,CA2,t,CB2,t,CP2,t,CQ2);
xgrid; xtitle('RCMP-MULT-1b','t','CA2(azul), CB2(verde), CP2(rojo), CQ2(cian)');
