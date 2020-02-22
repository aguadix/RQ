clear; clc;
// RDMP-6.sce
// A <=> B
// Progresión óptima de temperatura

// CONSTANTES
kd0 = 1.94E15; ki0 = 6.26E19; // h-1
Ed = 44500; Ei = 59500; // cal/mol
R = 1.987; // cal/(mol*K)
Tmin = 500; dT = 0.1; Tmax = 650; T = Tmin:dT:Tmax; // K
kd = kd0*exp(-Ed./(R*T));
ki = ki0*exp(-Ei./(R*T));

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = f(t,x)
    CA = x(1)
    CB = x(2)
    r = kd*CA - ki*CB
    [rmax,indexTopt] = max(r)
    Topt = T(indexTopt)
    dCAdt = -rmax   // Balance de materia para A
    dCBdt =  rmax   // Balance de materia para B
    dxdt(1) = dCAdt
    dxdt(2) = dCBdt
    dxdt(3) = Topt  // Almacenar Topt
endfunction

// CONDICIONES INICIALES
CAini = 1; CBini = 0; // mol/L
xini = [CAini; CBini; 0];

// TIEMPO
tfin = 5; dt = 0.01; t = 0:dt:tfin; // h

// RESOLVER
x = ode(xini,0,t,f);
CA = x(1,:); CAfin = CA($)
CP = x(2,:); CPfin = CP($)
XA = 1 - CA/CAini; XAfin = XA($)

for i = 1:length(t)
    dxdt(:,i) = f(t(i),x(:,i));
end

Topt = dxdt(3,:); Toptfin = Topt($)

indexTnomax = find(Topt<Tmax,1);
tTnomax = t(indexTnomax)
XATnomax = XA(indexTnomax)
ToptTnomax = Topt(indexTnomax)

// GRÁFICAS
scf(1); clf(1); 
plot(t,XA,tTnomax,XATnomax,'ro');
xgrid; xtitle('RDMP-6','t','XA');

scf(2); clf(2); 
plot(t,Topt,tTnomax,ToptTnomax,'ro');
xgrid; xtitle('RDMP-6','t','Topt');
