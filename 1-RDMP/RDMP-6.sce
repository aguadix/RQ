clear; clc;
// RDMP-6.sce
// A <=> B
// Progresión óptima de temperatura

// PARTE 1

// CONSTANTES
kd0 = 1.94E15; ki0 = 6.26E19; // h-1
Ed = 44500; Ei = 59500; // cal/mol
R = 1.987; // cal/(mol*K)
Tmin = 500; dT = 0.1; Tmax = 650; T = Tmin:dT:Tmax; // K
kd = kd0*exp(-Ed./(R*T)); // Ecuación de Arrhenius directa
ki = ki0*exp(-Ei./(R*T)); // Ecuación de Arrhenius inversa

// CONDICIONES INICIALES
CAini = 1; CBini = 0; // mol/L

XA = 0;

CA = CAini - CAini*XA
CB = CBini + CAini*XA

// Velocidad de reacción
// r = rd - ri
r = kd*CA - ki*CB;
// Velocidad máxima
[rmax,indexTopt] = max(r)
// Temperatura óptima
Topt = T(indexTopt)

// GRÁFICAS
scf(1);  
plot(T,r,Topt,rmax,'ro');
xgrid; xtitle('RDMP-6','T','r');

// PARTE 2

// SISTEMA DE ECUACIONES DIFERENCIALES
function dxdt = f(t,x)
    // Variables diferenciales
    CA = x(1)
    CB = x(2)
    // Velocidad de reacción
    // r = rd - ri
    r = kd*CA - ki*CB
    // Velocidad máxima
    [rmax,indexTopt] = max(r)
    // Temperatura óptima
    Topt = T(indexTopt)
    // Balance de materia para A
    // d(V*CA)dt = -rmax*V
    dCAdt = -rmax   
    // Balance de materia para B
    // d(V*CB)dt = rmax*V
    dCBdt =  rmax   
    // Derivadas
    dxdt(1) = dCAdt
    dxdt(2) = dCBdt
    dxdt(3) = Topt  // Almacenar Topt
endfunction

// CONDICIONES INICIALES
xini = [CAini; CBini; 0];

// TIEMPO
tfin = 5; dt = 0.01; t = 0:dt:tfin; // h

// RESOLVER
x = ode(xini,0,t,f);
CA = x(1,:); CAfin = CA($)
CB = x(2,:); CBfin = CB($)
XA = 1 - CA/CAini; XAfin = XA($)

for i = 1:length(t)
    dxdt(:,i) = f(t(i),x(:,i));
end

Topt = dxdt(3,:); Toptfin = Topt($)

indexToptTmax = find(Topt<Tmax,1);
tToptTmax = t(indexToptTmax)
XAToptTmax = XA(indexToptTmax)
ToptTmax = Topt(indexToptTmax)

// GRÁFICAS
scf(2); clf(2); 
plot(t,XA,tToptTmax,XAToptTmax,'ro');
xgrid; xtitle('RDMP-6','t','XA');

scf(3); clf(3); 
plot(t,Topt,tToptTmax,ToptTmax,'ro');
xgrid; xtitle('RDMP-6','t','Topt');
