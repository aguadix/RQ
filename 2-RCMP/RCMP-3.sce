clear; clc; 
// RCMP-3.sce
// A => B
// No adiabático

// (a) Método. gráfico

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
xlabel('CA'); CAmin = 0; CAmax = 3;
ylabel('T'); Tmin = 280; Tmax = 500;

dT = 0.1; T = Tmin:dT:Tmax;
k = k0*exp(-E./(R*T)); // Ecuación de Arrhenius
Q = UA*(T-TJ); // Calor transferido del reactor a la camisa

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

// LOCALIZACIÓN DE ESTADOS ESTACIONARIOS
y = CAbm-CAbe;
indexy0 = find(y(1:$-1).*y(2:$)<0)+1;
CAeeg = CAbm(indexy0)
Teeg = T(indexy0)
plot(CAeeg,Teeg,'ro');

// (b) Estado estacionario

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

// SOLUCIÓN SUPUESTA
CAeeguess = 2.5; // mol/L
Teeguess = 293; // K
xeeguess = [CAeeguess; Teeguess];

// RESOLVER
[xee,v,info] = fsolve(xeeguess,f)
CAee = xee(1)
Tee = xee(2)
plot(CAee,Tee,'x');

// ESTABILIDAD
J = numderivative(f,xee) // Jacobiano
lambda = spec(J)  // Valores propios
Estable = and(real(lambda) < 0)

// (c) Dinámica

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = g(t,x)
    dxdt = f(x)
endfunction

// CAMPO VECTORIAL
dCA = 0.1; dT = 10;
fchamp(g,0,CAmin:dCA:CAmax,Tmin:dT:Tmax);

// CONDICIONES INICIALES
CAini = 0; // mol/L
Tini = 280; // K
xini = [CAini; Tini];

// TIEMPO
tfin = 1000; dt = 1; t = 0:dt:tfin; // s

// RESOLVER
x = ode(xini,0,t,g);
CA = x(1,:); CAfin = CA($)
T = x(2,:); Tfin = T($)
plot(CA,T,'bo-');

a1 = gca;
a1.data_bounds = [CAmin, Tmin ; CAmax,Tmax];
