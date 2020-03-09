clear; clc;
// RCMP-3a.sce
// A => B
// No adiabático
// Estado estacionario

// SISTEMA DE ECUACIONES ALGEBRAICAS
function dxdt = f(x)
    // Variables
    CA = x(1)
    T  = x(2)
    // Ecuación de Arrhenius
    k = k0*exp(-E/(R*T))
    // Velocidad de reacción
    r = k*CA
    // Calor transferido del reactor a la camisa
    Q = UA*(T-TJ)
    // Balance de materia para A
    //d(V*CA)dt = F*CA0 - F*CA - r*V
    dCAdt = F*(CA0-CA)/V - r
    // Balance de energía
    // d(V*RHO*CP*T)dt = F*RHO*CP*T0 - F*RHO*CP*T -H*r*V - Q
    dTdt = F*(T0-T)/V - H*r/(RHO*CP) - Q/(V*RHO*CP) 
    // Derivadas
    dxdt(1) = dCAdt
    dxdt(2) = dTdt
endfunction

// CONSTANTES
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

// SOLUCIÓN SUPUESTA
CAeeguess = 2.5; // mol/L
Teeguess = 293; // K
xeeguess = [CAeeguess; Teeguess];

// RESOLVER
[xee,v,info] = fsolve(xeeguess,f)
CAee = xee(1)
Tee = xee(2)

// ESTABILIDAD DE LOS ESTADOS ESTACIONARIOS
J = numderivative(f,xee)  // Jacobiano
lambda = spec(J)  // Valores propios
Estable = real(lambda) < 0

// GRÁFICAS
CAmin = 0; dCA = 0.1; CAmax = 3;
Tmin = 280; dT = 0.1; Tmax = 500;

T = Tmin:dT:Tmax;
k = k0*exp(-E./(R*T));
// Balance de materia para A
// d(V*CA)dt = F*CA0 - F*CA - r*V = F*CA0 - F*CA - k*CA*V = 0
// F*CA0 = CA * (F + k*V)
CAbm = F*CA0./(F+k*V);
Q = UA*(T-TJ);
// Balance de energía
// d(V*RHO*CP*T)dt = F*RHO*CP*T0 - F*RHO*CP*T -H*r*V - Q = 0
// F*RHO*CP*(T0-T) - Q = H*k*CA*V
CAbe = (F*RHO*CP*(T0-T) - Q)./(H*k*V); 

scf(1); clf(1);
plot(CAbm,T,'g',CAbe,T,'r');
xtitle('RCMP-3a','CA','T');
mtlb_axis([CAmin CAmax Tmin Tmax]);

// Localización de estados estacionarios
Nee = 0;
for i = 1:length(T)-1
    if sign(CAbm(i)-CAbe(i)) <> sign(CAbm(i+1)-CAbe(i+1)) then
        Nee = Nee+1;
        Teeg = T(i)
        CAeeg = CAbm(i)
        plot(CAeeg,Teeg,'ro');
    end
end

plot(CAee,Tee,'rx');
