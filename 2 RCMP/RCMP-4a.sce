clear; clc;
// RCMP-4a
// A => B
// No adiabático
// Método gráfico

CP = 0.8; // cal/(g*K)
RHO = 1000; // g/L
F = 20; // L/s
V = 1500; // L
UA = 10000; // cal/(K*s)
H = -80000; // cal/mol
T0 = 293; // K
TJ = 283; // K
CA0 = 2.5; // mol/L
k0 = 2.5E10; // 1/s
R = 1.987; // cal/(mol*K)
E = 21000; // cal/mol

T = 280:0.1:500;
k = k0*exp(-E./(R*T));
CA = CA0./(1+k*V/F);
r = k.*CA;
Q = UA*(T-TJ);

HG = -H*r*V; // Calor ganado
HL = F*RHO*CP*(T-T0) + Q; // Calor perdido

Nee = 0;
for i = 1:length(T)-1
    if sign(HG(i)-HL(i)) <> sign(HG(i+1)-HL(i+1)) then
        Nee = Nee+1;
        Tee(Nee) = T(i)
        CAee(Nee) = CA(i)
    end
end

scf(1); clf(1); 
plot(T, HG, T, HL);
xgrid; xtitle('RCMP-4a','T','HG(azul), HL(verde)')