clear; clc;
// RDMP-3c.sce
// A => B
// No adiabático: serpentín

// SECTORES
N = 10; // divisiones del serpentín

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = f(t,x)
    // Variables diferenciales
    Ts = x(1:N)
    CA = x(N+1)
    T  = x(N+2)
    // Calor transferido del reactor al serpentín
    Q(1:N) = U*As*(T-Ts)
    // Balance de energía en el serpentín
    // d(Vs*RHOs*CPs*Ts(i))dt =  Fs*RHOs*CPs*Ts(i-1) - Fs*RHOs*CPs*Ts(i) + Q(i)
    // Sector 1
    dTsdt(1) = Fs*(Ts0-Ts(1))/Vs + Q(1)/(Vs*RHOs*CPs)
    // Resto de sectores
    dTsdt(2:N) = Fs*(Ts(1:N-1)-Ts(2:N))/Vs + Q(2:N)/(Vs*RHOs*CPs)
    // Ecuación de Arrhenius
    k = k0*exp(-E/(R*T))
    // Velocidad de reacción
    r = k*CA
    // Balance de materia para A
    // d(V*CA)dt = -r*V
    dCAdt = -r  
    // Balance de energía en el reactor
    // d(V*RHO*CP*T)dt = -H*r*V - Q
    dTdt  = -H*r/(RHO*CP) - sum(Q)/(V*RHO*CP)  
    // Derivadas
    dxdt(1:N) = dTsdt
    dxdt(N+1) = dCAdt
    dxdt(N+2) = dTdt
endfunction

// CONSTANTES
V = 1; // m3
RHO = 980; // kg/m3
CP = 4200; //J/(kg*K)

U = 400; // J/(m2*s*K)
Ds = 0.1; // m
Lstot = 13; // m
Vstot = %pi/4*Ds^2*Lstot // m3
Astot = %pi*Ds*Lstot  // m2
Vs = Vstot/N  // m3
As = Astot/N  // m2
Fs = 1E-3; //m3/s
Ts0 = 283; // K
RHOs = 1000; // kg/m3
CPs = 4180; //J/(kg*K)

H = -5E5; // J/mol
k0 = 2.2E4; // s-1
E = 41570; // J/mol
R = 8.314; // J/(mol*K)

// CONDICIONES INICIALES
Tsini(1:N) = 283; // K
CAini = 500; // mol/m3
Tini = 283; // K
xini = [Tsini; CAini; Tini];

// TIEMPO
tfin = 1500; dt = 1; t = 0:dt:tfin; // s

// RESOLVER
x = ode(xini,0,t,f);
Ts = x(1:N,:); Tsfin = Ts(:,$)
CA = x(N+1,:); CAfin = CA($)
T  = x(N+2,:); Tfin = T($)

[Tmax,indexTmax] = max(T)
tTmax = t(indexTmax)

// GRÁFICAS
scf(1); clf(1);
plot(t,CA);
xgrid; xlabel('t'); legend('CA',-2,%f);

scf(2); clf(2);
plot(t,T,'r-',t,Ts,'r:',tTmax,Tmax,'ro');
xgrid; xlabel('t'); legend('T','Ts',-2,%f);

scf(3); clf(3);
plot(Tsini,'ro-');      // t=0
plot(Ts(:,$/2),'ro-');  // t=tfin/2
plot(Tsfin,'ro-');      // t=tfin
xgrid; xlabel('Sector'); ylabel('Ts');
