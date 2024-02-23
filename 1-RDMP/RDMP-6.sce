clear; clc;
// RDMP-6.sce
// A <=> B
// Progresión óptima de temperatura

// (a)

// CONSTANTES
kd0 = 1.94E15; ki0 = 6.26E19; // h-1
Ed = 44500; Ei = 59500; // cal/mol
R = 1.987; // cal/(mol*K)
Tmin = 500.0; dT = 0.1; Tmax = 650.0; T = Tmin:dT:Tmax; // K
kd = kd0*exp(-Ed./(R*T)); // Ecuación de Arrhenius directa
ki = ki0*exp(-Ei./(R*T)); // Ecuación de Arrhenius inversa

// CONDICIONES INICIALES
CAini = 1; CBini = 0; // mol/L

XA = 0.0;

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
plot(T,r,Topt,rmax,'bo');
xgrid; xlabel('T'); ylabel('r');
a1 = gca;
a1.log_flags = "nl" ;

// (b)

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
Topt = diff(x(3,:))/dt; Toptfin = Topt($)
XA = 1 - CA/CAini; XAfin = XA($)

// GRÁFICAS
scf(2); clf(2); 
plot(t,XA,'m-');
xgrid; xlabel('t'); legend('XA',-2,%f);

scf(3); clf(3); 
plot(t(1:$-1),Topt,'r-');
xgrid; xlabel('t'); legend('Topt',-2,%f);

indexTc = find(Topt<Tmax-1E-6,1);
tTc = t(indexTc)
Tc = Topt(indexTc)
plot(tTc,Tc,'ro');
