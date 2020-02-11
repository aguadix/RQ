clear; clc;
// RDMP-3c.sce
// A => B
// No adiabático: serpentín

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = f(t,x)

    Ts = x(1:N)
    CA = x(N+1)
    T  = x(N+2)

    i = 1:N; Q(i) = U*As*(T-Ts(i))

    // Balance de energía en el serpentín (sector 1)
    dTsdt(1) = Fs*(Ts0-Ts(1))/Vs + Q(1)/(Vs*RHOs*CPs)

    // Balance de energía en el serpentín (resto de sectores)
    i = 2:N; dTsdt(i) = Fs*(Ts(i-1)-Ts(i))/Vs + Q(i)/(Vs*RHOs*CPs)

    k = k0*exp(-E/(R*T))
    r = k*CA
    dCAdt = -r  // Balance de materia para A
    dTdt  = -H*r/(RHO*CP) - sum(Q)/(V*RHO*CP)  // Balance de energía en el reactor

    dxdt(1:N) = dTsdt
    dxdt(N+1) = dCAdt
    dxdt(N+2) = dTdt

endfunction

// SECTORES
N = 10; // divisiones del serpentín

// CONSTANTES
V = 1; // m3
RHO = 980; // kg/m3
CP = 4200; //J/(kg*K)

U = 400; // J/(m2*s*K)
Ds = 0.1; // m
Ls = 13; // m
Vst = %pi/4*Ds^2*Ls // m3
Ast = %pi*Ds*Ls  // m2
Vs = Vst/N  // m3
As = Ast/N  // m2
Fs = 1E-3; //m3/s
Ts0 = 283; // K
RHOs = 1000; // kg/m3
CPs = 4180; //J/(kg*K)

H = -5E5; // J/mol
k0 = 2.2E4; // s-1
E = 41570; // J/mol
R = 8.314; // J/(mol*K)

// CONDICIONES INICIALES
i = 1:N; Tsini(i) = 283; // K
CAini = 500; // mol/m3
Tini = 283; // K
xini = [Tsini; CAini; Tini];

// VECTOR DE TIEMPOS
tfin = 1500; dt = 1; t = 0:dt:tfin; // s

// RESOLVER
x = ode(xini,0,t,f);
Ts = x(1:N,:); Tsfin = Ts(:,$)
CA = x(N+1,:); CAfin = CA($)
T  = x(N+2,:); Tfin = T($)

// GRÁFICAS
scf(1); clf(1);
plot(t,CA);
xgrid; xtitle('RDMP-3c','t','CA');

scf(2); clf(2);
plot(t,T,t,Ts);
xgrid; xtitle('RDMP-3c','t','T(azul), Ts(sectores)');
