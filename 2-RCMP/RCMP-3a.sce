clear; clc;
// RCMP-3a.sce
// A => B
// No adiabático
// Método gráfico

// CONSTANTES
CP = 0.8; // cal/(g*K)
RHO = 1000; // g/L
F = 20; // L/s
V = 1500; // L
UA = 1E4; // cal/(K*s)
H = -8E4; // cal/mol
T0 = 293; // K
TJ = 283; // K
CA0 = 2.5; // mol/L
k0 = 2.5E10; // 1/s
R = 1.987; // cal/(mol*K)
E = 2.1E4; // cal/mol

// BALANCES 

scf(1); clf(1);
xtitle('RCMP-3','CA','T');

CAmin = 0; dCA = 0.1; CAmax = 3;
Tmin = 280; dT = 0.1; Tmax = 500;

T = Tmin:dT:Tmax;
k = k0*exp(-E./(R*T));
Q = UA*(T-TJ);

// Balance de materia para A
// d(V*CA)dt = F*CA0 - F*CA - r*V = F*CA0 - F*CA - k*CA*V = 0
// F*CA0 = CA * (F + k*V)
CAbm = F*CA0./(F+k*V);
plot(CAbm,T,'r-');

// Balance de energía
// d(V*RHO*CP*T)dt = F*RHO*CP*T0 - F*RHO*CP*T -H*r*V - Q = 0
// F*RHO*CP*(T0-T) - Q = H*k*CA*V
CAbe = (F*RHO*CP*(T0-T) - Q)./(H*k*V); 
plot(CAbe,T,'r--');

a1 = gca;
a1.data_bounds = [CAmin, Tmin ; CAmax,Tmax];

// LOCALIZACIÓN DE ESTADOS ESTACIONARIOS
Nee = 0;
for i = 1:length(T)-1
    if sign(CAbm(i)-CAbe(i)) <> sign(CAbm(i+1)-CAbe(i+1)) then
        Nee = Nee+1
        Teeg(Nee) = T(i)
        CAeeg(Nee) = CAbm(i)
        plot(CAeeg,Teeg,'ro');
    end
end
