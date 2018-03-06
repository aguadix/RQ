clear; clc;
// RDMP-3c
// A => B
// No adiabático: serpentín

N = 5; // divisiones del serpentín

V = 1; // m3
RHO = 980; // kg/m3
CP = 4200; //J/(kg*K)

U = 400; // J/(m2*s*K)
Ds = 0.1; // m
Ls = 13; // m
Vst = %pi/4*Ds^2*Ls // m3
Ast = %pi*Ds*Ls  // m2
Vs = Vst/N
As = Ast/N
Fs = 1E-3; //m3/s
Ts0 = 283; // K
RHOs = 1000; // kg/m3
CPs = 4180; //J/(kg*K)

H = -5E5; // J/mol
k0 = 2.2E4; // s-1
E = 41570; // J/mol
R = 8.314; // J/(mol*K)

i = 1:N; Tsini(i) = 283; // K
CAini = 500; // mol/m3
Tini = 283; // K
xini = [Tsini; CAini; Tini];

tfin = 1400; dt = 1; // s
t = 0:dt:tfin;

function dxdt = f(t,x)
  
  i = 1:N
  Q(i) = U*As*(x(N+2)-x(i))
  
  dxdt(1) = Fs*(Ts0-x(1))/Vs + Q(1)/(Vs*RHOs*CPs)
  i = 2:N
  dxdt(i) = Fs*(x(i-1)-x(i))/Vs + Q(i)/(Vs*RHOs*CPs)

  k = k0*exp(-E/(R*x(N+2)))
  r = k*x(N+1)
  dxdt(N+1) = -r
  dxdt(N+2) = -H*r/(RHO*CP) - sum(Q)/(V*RHO*CP)
  
endfunction

x = ode(xini,0,t,f);
Ts = x(1:N,:); Tsfin = Ts(:,$)
CA  = x(N+1,:); CAfin = CA($)
T = x(N+2,:); Tfin = T($)

scf(1); clf(1);
plot(t,CA);
xgrid; xtitle('RDMP-3c','t','CA');

scf(2); clf(2);
plot(t,T);
xgrid; xtitle('RDMP-3c','t','T');

scf(3); clf(3);
plot(t,Ts);
xgrid; xtitle('RDMP-3c','t','Ts');