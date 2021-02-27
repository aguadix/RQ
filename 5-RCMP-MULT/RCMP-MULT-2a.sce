clear; clc;
// RCMP-MULT-2a.sce
// 1) 2 A => B
// 2)   A => C 
// No adiabático
// Método gráfico
// https://youtu.be/SXK8s3CO6gU

// CONSTANTES
V   =  0.1; // L
F   =  0.01; // L/s 	
CA0 =  10; // mol/L  
T0  =  318; // K
TJ  =  318; // K
UA  =  371; // J/(s*K) 
CP  =  4.18; // J/(g*K)
RHO =  1000; // g/L
k01 =  1E16; // L/(s*mol)
E1  =  1.2E5; // J/mol 
H1  = -1.13E5; // J/mol
k02 =  9.5E12; // 1/s
E2  =  8.8E4; // J/mol 
H2  = -8.37E4; // J/mol
R   =  8.314; // J/(mol*K)

// BALANCES 
scf(1); clf(1);
xtitle('RCMP-MULT-2','CA','T');

CAmin = 0;   dCA = 0.01; CAmax = 10;  // mol/L
Tmin  = 310; dT  = 0.1;  Tmax  = 350; // K 

T = Tmin:dT:Tmax;
k1 = k01*exp(-E1./(R*T));
k2 = k02*exp(-E2./(R*T));
Q = UA*(T-TJ);

// Balance de materia para A
// d(V*CA)dt = F*CA0 - F*CA - r1*V - r2*V 
// 0 = F*CA0 - F*CA - k1*CA^2*V - k2*CA*V
a = -k1*V; b = -F-k2*V; c = F*CA0;
CAbm = (-b-sqrt(b^2-4*a*c))./(2*a);
plot(CAbm,T,'r-');

// Balance de energía
// d(V*RHO*CP*T)dt = F*RHO*CP*T0 - F*RHO*CP*T - H1*r1*V - H2*r2*V - Q
// 0 = F*RHO*CP(T0-T) - H1*k1*CA^2*V - H2*k2*CA*V - Q
a = -H1*k1*V; b = -H2*k2*V; c = F*RHO*CP*(T0-T) - Q;
CAbe = (-b+sqrt(b^2-4*a.*c))./(2*a)
plot(CAbe,T,'r--');

a1 = gca;
a1.data_bounds = [CAmin, Tmin ; CAmax,Tmax];

// LOCALIZACIÓN DE ESTADOS ESTACIONARIOS
for i = 1:length(T)-1
    if sign(CAbm(i)-CAbe(i)) <> sign(CAbm(i+1)-CAbe(i+1)) then
        Teeg = T(i)
        CAeeg = CAbm(i)
        plot(CAeeg,Teeg,'ro');
    end
end
