clear; clc;
// RDMP-6.sce
// A <=> B
// Progresión óptima de temperatura

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = f(t,x)
    CA = x(1)
    CB = x(2)
    r = kd*CA - ki*CB
    [rmax,index] = max(r)
    Topt = T(index)
    dCAdt = -rmax   // Balance de materia para A
    dCBdt =  rmax   // Balance de materia para B
    dIntegralToptdt = Topt  // Almacenar Topt  
    dxdt(1) = dCAdt
    dxdt(2) = dCBdt
    dxdt(3) = dIntegralToptdt
endfunction

// CONSTANTES
kd0 = 1.94E15; ki0 = 6.26E19; // h-1
Ed = 44500; Ei = 59500; // cal/mol
R = 1.987; // cal/(mol*K)
Tmin = 500; dT = 0.1; Tmax = 650; T = Tmin:dT:Tmax; // K
kd = kd0*exp(-Ed./(R*T));
ki = ki0*exp(-Ei./(R*T));

// CONDICIONES INICIALES
CAini = 1; CBini = 0; // mol/L
IntegralToptini = 0;
xini = [CAini; CBini; IntegralToptini];

// TIEMPO
tfin = 5; dt = 0.01; t = 0:dt:tfin; // h

// RESOLVER
x = ode(xini,0,t,f);
CA = x(1,:); CAfin = CA($)
CP = x(2,:); CPfin = CP($)

ITopt = x(3,:);
i = 1:length(t)-1; 
Topt(i) = (ITopt(i+1)-ITopt(i))/dt; 
Toptfin = Topt($)

XA = 1 - CA/CAini; XAfin = XA($)

indexTmax = find(Topt<Tmax-1E-6,1);
tTmax = t(indexTmax)
XATmax = XA(indexTmax)
ToptTmax = Topt(indexTmax)

// GRÁFICAS
scf(1); clf(1); 
plot(t,XA,tTmax,XATmax,'ro');
xgrid; xtitle('RDMP-6','t','XA');

scf(2); clf(2); 
plot(t(1:$-1),Topt,tTmax,ToptTmax,'ro');
xgrid; xtitle('RDMP-6','t','Topt');
