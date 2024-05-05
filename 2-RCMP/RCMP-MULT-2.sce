clear; clc;
// RCMP-MULT-2a.sce
// 1) 2 A => B
// 2)   A => C 
// No adiabático

// (a) Método. gráfico

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
xlabel('CA'); CAmin = 0; CAmax = 10;
ylabel('T'); Tmin = 310; Tmax = 350;

dT = 0.1; T = Tmin:dT:Tmax;
k1 = k01*exp(-E1./(R*T)); // Ecuación de Arrhenius
k2 = k02*exp(-E2./(R*T)); // Ecuación de Arrhenius
Q = UA*(T-TJ); // Calor transferido del reactor a la camisa

// Balance de materia para A
// d(V*CA)dt = F*CA0 - F*CA - r1*V - r2*V 
// 0 = F*CA0 - F*CA - k1*CA^2*V - k2*CA*V
a = -k1*V; b = -F-k2*V; c = F*CA0;
CAbm = (-b-sqrt(b.^2-4*a.*c))./(2*a);
plot(CAbm,T,'r-');

// Balance de energía
// d(V*RHO*CP*T)dt = F*RHO*CP*T0 - F*RHO*CP*T - H1*r1*V - H2*r2*V - Q
// 0 = F*RHO*CP(T0-T) - H1*k1*CA^2*V - H2*k2*CA*V - Q
a = -H1*k1*V; b = -H2*k2*V; c = F*RHO*CP*(T0-T) - Q;
CAbe = (-b+sqrt(b.^2-4*a.*c))./(2*a)
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
    // Ecuaciones de Arrhenius
    k1 = k01*exp(-E1/(R*T)) 
    k2 = k02*exp(-E2/(R*T)) 
    // Velocidades de reacción
    r1 = k1*CA^2
    r2 = k2*CA
    // Balance de materia para A
    // d(V*CA)dt = F*CA0 - F*CA - r1*V - r2*V
    dCAdt = F*(CA0-CA)/V - r1 - r2
    // Calor transferido del reactor a la camisa
    Q = UA*(T-TJ)
    // Balance de energía
    // d(V*RHO*CP*T)dt = F*RHO*CP*T0 - F*RHO*CP*T - H1*r1*V - H2*r2*V - Q
    dTdt = F*(T0-T)/V - (H1*r1 + H2*r2)/(RHO*CP) - Q/(V*RHO*CP)
    // Derivadas
    dxdt(1) = dCAdt
    dxdt(2) = dTdt
endfunction

// SOLUCIÓN SUPUESTA
CAeeguess = 10; // mol/L 
Teeguess = 318; // K
xeeguess = [CAeeguess;Teeguess];

// RESOLVER
[xee,fxee,info] = fsolve(xeeguess,f)
CAee = xee(1)
Tee = xee(2)
plot(CAee,Tee,'x');

// ESTABILIDAD
J = numderivative(f,xee); // Jacobiano
lambda = spec(J) // Valores propios
Estable = and(real(lambda) < 0)

// (c)Dinámica

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = g(t,x)
    dxdt = f(x)
endfunction

// CAMPO VECTORIAL
dCA = 0.5; dT  = 2;
fchamp(g,0,CAmin:dCA:CAmax,Tmin:dT:Tmax);

// CONDICIONES INICIALES
CAini = 0; // mol/L
Tini  = 310; // K
xini = [CAini;Tini];

// TIEMPO
tfin = 100; dt = 0.1; t = 0:dt:tfin; //s

// RESOLVER
x = ode(xini,0,t,g);
CA = x(1,:); CAfin = CA($)
T  = x(2,:); Tfin = T($)
plot(CA,T,'bo-');

a1 = gca;
a1.data_bounds = [CAmin, Tmin ; CAmax,Tmax];
